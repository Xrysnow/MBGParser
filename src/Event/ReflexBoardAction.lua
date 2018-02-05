

mbg.ReflexBoardAction = {}

local function _ReflexBoardAction()
    return {
        LValue   = '',
        RValue   = '',
        Operator = 0,
    }
end

local mt = {
    __call = function()
        return _ReflexBoardAction()
    end
}
setmetatable(mbg.ReflexBoardAction, mt)

function mbg.ReflexBoardAction.ParseFrom(c)
    local r = mbg.ReflexBoardAction()
    mbg.ActionHelper.ParseFirstSentence(c, r)
    return r
end

function mbg.ReflexBoardAction.ParseActions(c)
    if not c or c:isempty() then
        return nil
    else
        local ret     = {}
        local actions = c:split('&')
        for _, v in ipairs(actions) do
            if v ~= '' then
                table.insert(ret, mbg.ReflexBoardAction.ParseFrom(String(v)))
            end
        end
        return ret
    end
end
