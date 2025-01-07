{
  const uniquize = function(list) {
    if(!Array.isArray(list)) { return list }
    if(list.length === 1) { return list[0] }
    return list;
  }
}
Language = ___* ast:Block ___* { return ast }
Block = s:Full_sentence* { return uniquize(s) }
Full_sentence = sentence:Sentence eos:EOS { return sentence }
Sentence = g:Group_of_any+ { return uniquize(g) }
Group_of_any = Group_of_word_appended / Group_of_logic
Group_of_word_appended = words:Group_of_words logic:Group_of_logic? { return { [words.trim()]: logic } }
Group_of_words = words:Separated_words Separator? { return words }
Separated_words = Separated_word+ { return text() }
Separated_word = separator:Separator? words:Spaced_words separator2:Separator? { return text() }
Separator = (("."(!__))/","/";"/":"/"/"/"*"/"=") {}
Spaced_words = Spaced_word+ { return text() }
Spaced_word = ___* word:Word { return word }
Word = Word_character+ { return text() }
Word_character = [A-Za-z0-9Ññ_\$\-ÁÉÍÓÚáéíóúÀÈÌÒÙàèìòùÂÊÎÔÛâêîôûÄËÏÖÜäëïöü·'"=\*] { return text() }
Group_of_logic = Group_of_logic_1 / Group_of_logic_2 / Group_of_logic_3
Group_of_logic_1 = ___* "[" ___* group:Block ___* "]" { return group }
Group_of_logic_2 = ___* "{" ___* group:Block ___* "}" { return group }
Group_of_logic_3 = ___* "(" ___* group:Block ___* ")" { return group }
_ = " " / "\t"
__ = "\r\n" / "\r" / "\n"
___ = _ / __
EOS = ("." / "!" / "?" / "") !(!(___/EOF/")"/"}"/"]")) { return text() }
EOF = !.