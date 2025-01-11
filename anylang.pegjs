{
  const startTime = new Date();
  const spliter_regex_base = "|;:.,/\\".split("");
  let splitter_regex_text = ""; 
  splitter_regex_text += "^( |\n|\t|\r)*(";
  splitter_regex_text += spliter_regex_base.map(s => "\\" + s).join("|");
  splitter_regex_text += ")?( |\n|\t|\r)*$";
  const spliter_regex = new RegExp(splitter_regex_text, "g");
  const neutralize_text = function(txt) {
    return txt;
    return txt.match(spliter_regex) ? null : txt;
  };
  const stopTime = function() {
    return (new Date()) - startTime + " milliseconds";
  };
  const flatenize = function(groups) {
    if(!Array.isArray(groups)) {
      return groups;
    }
    const out = {};
    Iterating_groups:
    for(let index=0; index<groups.length; index++) {
      const group = groups[index];
      if(group === null) {
        continue Iterating_groups;
      }
      Object.assign(out, group);
    }
    return out;
  };
  const deanulize = function(l) {
    let out = [];
    for(let index=0; index<l.length; index++) {
      const item = l[index];
      if(Array.isArray(item)) {
        if(item.length === 0) {
          // @ok
        } else if(item.length === 1) {
          out.push(item[0]);
        } else {
          out.push(deanulize(item));
        }
      } else if(item === null) {
        // ok
      } else {
        out.push(item);
      }
    }
    return out;
  }
}
Language = ast:Block { return ast }
Block = s:Full_sentence? { return s }
Full_sentence = sentence:Sentence { return sentence }
Sentence = g:Group_of_any+ { return flatenize(g) }
Group_of_any = Group_of_words_with_logic / Group_of_logic / Separator_symbol
Group_of_words_with_logic = w:Group_of_words l:Group_of_logic* { return {[w.trim()]:l} }
Group_of_words = ((!("[" / "{" / "(" / "}" / "]" / ")" / Separator_symbol )) .)+ { return neutralize_text(text()) } 
Group_of_logic = Group_of_logic_0 / Group_of_logic_1 / Group_of_logic_2 / Group_of_logic_3
Group_of_logic_0 = "{{" group:Negate_double_curly_brackets "}}" ___* { return group }
Group_of_logic_1 = "[" ___* group:Block "]" ___* { return group }
Group_of_logic_2 = "{" ___* group:Block "}" ___* { return group }
Group_of_logic_3 = "(" ___* group:Block ")" ___* { return group }
Negate_double_curly_brackets = ((!"}}") .)* { return text() }
Separator_symbol = ___* (";\n") ___* { return null }
_ = "\t" / " "
__ = "\r\n" / "\r" / "\n"
___ = _ / __
EOF = !.