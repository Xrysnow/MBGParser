---
--- CommandAction.lua
---
--- Copyright (C) 2018 Xrysnow. All rights reserved.
---


---@class mbg.CommandAction:mbg.IAction
local CommandAction = {}
mbg.CommandAction = CommandAction

local function _CommandAction()
    ---@type mbg.CommandAction
    local ret = {}
    ret.Command   = String()
    ret.Arguments = {}
    return ret
end

local mt = {
    __call = function()
        return _CommandAction()
    end
}
setmetatable(CommandAction, mt)

---ParseFrom
---@param c String
---@return mbg.CommandAction
function CommandAction.ParseFrom(c)
    local s     = c:split('，')
    local a     = mbg.CommandAction()
    a.Arguments = nil
    a.Command   = s[1]
    if #s > 1 then
        a.Arguments = {}
        for i = 2, #s do
            table.insert(a.Arguments, s[i])
        end
    end
    return a
end

