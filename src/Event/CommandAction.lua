

mbg.CommandAction = {}

local function _CommandAction()
    local ret = {
        Command   = String(),
        Arguments = {}
    }
    return ret
end

local mt = {
    __call = function()
        return _CommandAction()
    end
}
setmetatable(mbg.CommandAction, mt)

function mbg.CommandAction.ParseFrom(c)
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
