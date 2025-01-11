const fs = require("fs");
const child_process = require("child_process");

describe("AnylangParser API Test", function () {

  it("can load the parser and parse a simple sentence", async function () {
    require(__dirname + "/../anylang.js");
    const ast = AnylangParser.parse("Hello from Anylang!");
    if (typeof ast !== "object") {
      throw new Error("1: cannot parse a simple sentence");
    }
  });

  const examples = fs.readdirSync(__dirname + "/examples");
  for (let index = 0; index < examples.length; index++) {
    const example_file = __dirname + "/examples/" + examples[index];
    it(`can parse example file ${examples[index]}`, async function () {
      try {
        const example_output_file = __dirname + "/examples-output/" + examples[index].replace(/\.any$/g, ".json");
        const example = fs.readFileSync(example_file).toString();
        const example_output = AnylangParser.parse(example)
        fs.writeFileSync(example_output_file, JSON.stringify(example_output, null, 2), "utf8");
      } catch (error) {
        console.error(error);
      }
    });
  }

  it("can use binary to compile from console", async function () {
    child_process.execSync("anylang compile examples-bin/*.any", {
      cwd: __dirname
    });
  });

});