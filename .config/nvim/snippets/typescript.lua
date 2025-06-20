local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s("log", {
    t("console.log("),
    i(1, "msg"),
    t(");"),
  }),
  s("ser-inject", {
    t("private readonly _"),
    i(1, "service"),
    t(" = inject("),
    i(2, "Service"),
    t(");"),
  }),
  s("sus-create", {
    t("private "),
    i(1, "name"),
    t("Subscription: Subscription | null = null;"),
  }),
  s("inp-create", {
    t("@Input() "),
    i(1, "prop"),
    t(": "),
    i(2, "Type"),
    t(" | null = null;"),
  }),
  s("auth-context", {
    t("this.authSubscription = this._authService.getAuthPermisoGroup("),
    i(1, "group"),
    t(").subscribe((res) =>"),
    t({ "", "{", "    " }),
    t("if (res)"),
    t({ "", "    {", "        " }),
    t("this._authService.setContext(res.context);"),
    t({ "", "    }", "});" }),
  }),
  s("create-form-control", {
    i(1, "name"),
    t(": new FormControl<"),
    i(2, "Type"),
    t(" | null>(null)"),
  }),
  s("auth-permiso-group", {
    t("public authPermisoGroup"),
    i(1, "Name"),
    t(": AuthPermisoGroupNameType = '"),
    i(2, "groupName"),
    t("';"),
  }),
}
