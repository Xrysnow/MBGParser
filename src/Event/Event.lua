

mbg.Event = {}

local function _Event()
    return {
        Condition = mbg.Condition(),
        Action    = nil,
    }
end

local mt = {
    __call = function()
        return _Event()
    end
}
setmetatable(mbg.Event, mt)

function mbg.Event.ParseFrom(c)
    local e     = mbg.Event()
    e.Condition = mbg.Condition.ParseFrom(mbg.ReadString(c, '：'))
    e.Action    = mbg.ActionHelper.ParseFrom(c)
    return e
end

function mbg.Event.ParseEvents(c)
    if not c or c:isempty() then
        return nil
    else
        local ret    = {}
        local events = c:split(';')
        for _, v in pairs(events) do
            if v ~= '' then
                table.insert(ret, mbg.Event.ParseFrom(String(v)))
            end
        end
        return ret
    end
end

