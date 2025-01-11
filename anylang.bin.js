#!/usr/bin/env node

const args = [].concat(process.argv);
const node_path = args.shift();
const anylang_path = args.shift();
const command = args.shift();
const files = [].concat(args);
const available_commands = [ "compile" ];

if(available_commands.indexOf(command) === -1) {
  throw new Error("Command «" + command + "» is not recognized, only: " + available_commands.join(", "));
}

const fs = require("fs");
require(__dirname + "/anylang.js");

for(let index=0; index<files.length; index++) {
  const file = files[index];
  const file_out = file.replace(/\.any$/g, "") + ".json";
  const content = fs.readFileSync(file).toString();
  const ast = AnylangParser.parse(content);
  fs.writeFileSync(file_out, JSON.stringify(ast, null, 2), "utf8");
}