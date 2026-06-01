const fs = require('fs');

let fragmentMapPath = 'C:/Games/Tools/MO2/profiles/Skyrim Special Edition/mods/MINT/fragmentMap.json';
let scriptFolders = [
	'C:/Games/Steam/steamapps/common/Skyrim Special Edition/Data/Source/Scripts',
	'C:/Games/Tools/MO2/profiles/Skyrim Special Edition/mods/Unofficial Skyrim Special Edition Patch/source/scripts'
];

let file = fs.readFileSync(fragmentMapPath, {encoding:'utf8'});
let fragmentMap = JSON.parse(file);
let fragmentNames = Object.values(fragmentMap).map(v => Object.values(v)).flat();
let scripts = {};
fragmentNames.forEach(n => {
	let [scriptname, fragmentName] = n.split('.');
	if(scripts[scriptname] === undefined) scripts[scriptname] = {path: undefined};
	scripts[scriptname][fragmentName] = undefined;
});

let scriptnames = Object.keys(scripts);
console.log(`Read ${scriptnames.length} scripts to locate.`);

for(let i = 0; i < scriptFolders.length; i++){
	let dirPath = scriptFolders[i];
	for(let j = 0; j < scriptnames.length; j++){
		let filename = scriptnames[j];
		let path = `${dirPath}/${filename}.psc`;
		if(fs.existsSync(path)) scripts[filename].path = path;
	}
}
let missingScriptNames = Object.entries(scripts).filter(e => e[1].path === undefined).map(e => e[0]);
let missingCount = missingScriptNames.length;
if(missingCount > 0){
	console.log(`Could not locate ${missingCount} scripts.`);
	console.log(missingScriptNames.map(n => n + '.psc').join('\r\n'));
	return;
}
console.log('Located all scripts.');

for(let i = 0; i < scriptnames.length; i++){
	let scriptname = scriptnames[i];
	let script = scripts[scriptname];
	let path = script.path;
	let fragmentNames = Object.keys(script).slice(1);
	let sourceFile = fs.readFileSync(path, {encoding:'utf8'});
	let lines = sourceFile.split('\r\n');
	let lowerLines = lines.map(line => line.toLowerCase());
	for(let j = 0; j < fragmentNames.length; j++){
		let startLine = `Function ${fragmentNames[j]}(ObjectReference akSpeakerRef)`.toLowerCase();
		let startIndex = lowerLines.findIndex(line => line.startsWith(startLine));
		let endIndex = lowerLines.slice(startIndex).findIndex(line => line.startsWith('endfunction'));
		let fnBody = lines.slice(startIndex, startIndex + endIndex + 1).join('\r\n');
		script[fragmentNames[j]] = fnBody;
	}
	delete script.path;
}
let output = JSON.stringify(scripts,undefined,'\t');
let outPath = 'C:/Games/Tools/MO2/profiles/Skyrim Special Edition/mods/MINT/fragmentFunctions.json';
fs.writeFileSync(outPath, output, {encoding:'utf8'});