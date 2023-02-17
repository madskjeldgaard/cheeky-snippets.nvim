local function prequire(...)
  local status, lib = pcall(require, ...)
  if (status) then return lib end
  return nil
end
local ls = prequire('luasnip')
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local r = ls.restore_node
local rp = require("luasnip.extras").rep
local n = require("luasnip.extras").nonempty

return {
  --------------------------------------------------
  --                Class Template                --
  --------------------------------------------------
  s({trig="class", dscr="class template"}, {
    i(1, "Class"), t(" "), c(2, {
      sn("superclass", {
        t(": "), i(1,"Superclass"), t(" ")
      }),
      sn("blank", {
        i(1)
      }),
    }), t("{"), n(2, "", " // : Object "),
    c(3, {
      sn("classvar", {t({"","\tclassvar "}), i(1,"name"), t(";")}),
      sn("blank", {i(1)}),

    }),
    c(4, {
      sn("var", {t({"","\tvar "}), i(1,"name"), t(";")}),
      sn("get", {t({"","\tvar <"}), i(1,"name"), t(";")}),
      sn("set", {t({"","\tvar >"}), i(1,"name"), t(";")}),
      sn("get-set", {t({"","\tvar <>"}), i(1,"name"), t(";")}),
      sn("blank", {i(1)}),

    }),
    t({"", "","\t*new {"}),
    n(5," | ",""), c(5, {
      sn("args", {i(1,"a, b")}),
      sn("blank", {i(1)})
    }), n(5," |",""),
    t({"","\t\t^super"}), c(6, {
      sn("init", {t(".new.init("),i(1)}),
      sn("copy", {t(".newCopyArgs("),i(1)}),
    }), rp(5), t(")"),
    t({"","\t}"}),
    t({"","","\tinit {"}),
    t({"","\t\t"}), i(7,"// initiation"),
    t({"","\t}",""}),
    t({"","\t"}),c(8, {
      sn("method", {i(1, "newMethod"), t("{"),
        t({"","\t\t"}),i(2, "// ??"),
        t({"","\t}"}), i(0)
      }),
      sn("blank", {i(1)})
    }), i(0),
    t({"","}"}), t(" // "), rp(1)
  }),
}
