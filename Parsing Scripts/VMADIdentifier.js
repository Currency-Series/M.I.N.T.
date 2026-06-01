let filename = 'VendorTopics.esp';
let fragmentMapPath = 'C:/Games/Tools/MO2/profiles/Skyrim Special Edition/mods/MINT/fragmentMap.json';
let functionPath = 'C:/Games/Tools/MO2/profiles/Skyrim Special Edition/mods/MINT/fragmentFunctions.json';
let topicLimit = 10000;

let file = xelib.FileByName(filename);
let topics = xelib.GetRecords(file, 'DIAL', true);
let deleteTopic = topics.find(t => xelib.EditorID(t) === 'DELETE');
if(deleteTopic === undefined){
	deleteTopic = xelib.AddElement(file, 'DIAL\\DIAL');
	xelib.AddElementValue(deleteTopic, 'EDID', 'DELETE');
}

let topicCount = 0;
let infoCount = 0;

let n = topics.length > topicLimit? topicLimit : topics.length;
for(let i = 0; i < n; i++){
	let topic = topics[i];
	if(xelib.EditorID(topic) === 'DELETE') continue;
	let infos = xelib.GetRecords(topic, 'INFO', true);
	if(infos.length > 0){
		for(let j = 0; j < infos.length; j++){
			let info = xelib.GetWinningOverride(infos[j]);
			let formID = xelib.GetHexFormID(info);
			let hasScript = xelib.HasElement(info, 'VMAD');
			if(!hasScript) {
				xelib.SetLinksTo(info, deleteTopic, 'Topic');
				infoCount += 1;
			}
		}
		infos = xelib.GetRecords(topic, 'INFO', true);
	}
	if(infos.length === 0){
		xelib.HasElement(topic, 'EDID')? xelib.SetValue(topic, 'EDID', 'EMPTYTOPIC') : xelib.AddElementValue(topic, 'EDID', 'EMPTYTOPIC');
		topicCount += 1;
	}
}
if(topicCount > 0 || infoCount > 0){
	zedit.info(`Searched ${n === topics.length? n : (n + "/" + topics.length)} topics. Moved ${infoCount} infos with no attached script. ${topicCount} topics are empty and can be removed.`);
	return;
}

let fragmentMap = fh.loadJsonFile(fragmentMapPath, undefined);
if(fragmentMap === undefined){
	fragmentMap = {};
	for(let i = 0; i < n; i++){
		let topic = topics[i];
		let infos = xelib.GetRecords(topic, 'INFO', true);
		for(let j = 0; j < infos.length; j++){
			let info = infos[j];
			if(!xelib.HasElement(info, 'VMAD\\Script Fragments\\Flags')) continue;
			let formID = xelib.GetHexFormID(info);
			let fragCalls = {};
			let flags = xelib.GetEnabledFlags(info, 'VMAD\\Script Fragments\\Flags');
			for(let k = 0; k < flags.length; k++){
				let flag = flags[k];
				let scriptname = xelib.GetValue(info, `VMAD\\Script Fragments\\Fragments\\[${k}]\\scriptName`);
				let fragmentName = xelib.GetValue(info, `VMAD\\Script Fragments\\Fragments\\[${k}]\\fragmentName`);
				fragCalls[flag] = `${scriptname}.${fragmentName}`;
			}
			fragmentMap[formID] = fragCalls;
		}
	}
	fh.saveJsonFile(fragmentMapPath, fragmentMap);
}
let functionData = fh.loadJsonFile(functionPath, undefined);
if(functionData === undefined) return;

for(let i = 0; i < n; i++){
	let topic = topics[i];
	let infos = xelib.GetRecords(topic, 'INFO', true);
	for(let j = 0; j < infos.length; j++){
		let info = infos[j];
		let isBarterInfo = false;
		let formID = xelib.GetHexFormID(info);
		let scriptData = fragmentMap[formID];
		if(scriptData === undefined){
			//no fragments at all
			xelib.SetLinksTo(info, deleteTopic, 'Topic');
			infoCount += 1;
			continue;
		}
		let beginFragment = scriptData.OnBegin, endFragment = scriptData.OnEnd;
		if(beginFragment !== undefined){
			let [scriptname, fnName] = beginFragment.split('.');
			let fnBody = functionData[scriptname][fnName];
			if(fnBody.toLowerCase().includes('showbartermenu()')) isBarterInfo = true;
		}
		if(endFragment !== undefined){
			let [scriptname, fnName] = endFragment.split('.');
			let fnBody = functionData[scriptname][fnName];
			if(fnBody.toLowerCase().includes('showbartermenu()')) isBarterInfo = true;
		}
		if(!isBarterInfo){
			xelib.SetLinksTo(info, deleteTopic, 'Topic');
			infoCount += 1;
		}
	}
	if(infos.length === 0){
		xelib.HasElement(topic, 'EDID')? xelib.SetValue(topic, 'EDID', 'EMPTYTOPIC') : xelib.AddElementValue(topic, 'EDID', 'EMPTYTOPIC');
		topicCount += 1;
	}
}
if(topicCount > 0 || infoCount > 0){
	zedit.info(`Searched ${n === topics.length? n : (n + "/" + topics.length)} topics. Moved ${infoCount} infos with unrelated script. ${topicCount} topics are empty and can be removed.`);
	return;
}
zedit.info(`Searched ${n === topics.length? n : (n + "/" + topics.length)} topics. All appear to call the ShowBarterMenu() function.`);