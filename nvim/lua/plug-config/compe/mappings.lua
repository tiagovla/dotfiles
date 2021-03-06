local ezmap = require("ezmap")

local compe_mappings = {
    {"i", "<Tab>", "v:lua.tab_complete()"}, {"s", "<Tab>", "v:lua.tab_complete()"},
    {"i", "<S-Tab>", "v:lua.s_tab_complete()"}, {"s", "<S-Tab>", "v:lua.s_tab_complete()"},
}
ezmap.map(compe_mappings, {"expr", "silent"})
ezmap.map({{"i", "<CR>", "compe#confirm('<CR>')"}}, {"noremap", "expr", "silent"})

local function check_back_space()
    local col = vim.fn.col(".") - 1
    if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
        return true
    else
        return false
    end
end

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif check_back_space() then
        return t "<Tab>"
    else
        return vim.fn["compe#complete"]()
    end
end

_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    else
        return t "<S-Tab>"
    end
end
