const fs = require("fs");

const packageJson = require(__dirname + "/package.json");
const name = packageJson.name;
const version = packageJson.version;
const header = `/*
 * @package:   @allnulled/${ name }
 * @version:   ${ version }
 * @github:    https://github.com/allnulled/${ name }
 * @npm:       https://npmjs.com/@allnulled/${ name }
 * @download:  git clone https://github.com/allnulled/${name}.git --branch v${ version }
 * @install:   npm install -s ${name}@${ version }
 * @author:    https://github.com/allnulled
 */\n`;

let anylang_content = fs.readFileSync(__dirname + "/anylang.js").toString();
anylang_content = anylang_content.replace("\n})(this);", "\n})(typeof window !== 'undefined' ? window : global);");
anylang_content = header + anylang_content;

fs.writeFileSync(__dirname + "/anylang.js", anylang_content, "utf8");