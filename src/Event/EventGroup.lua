

mbg.EventGroup = {}

local function _EventGroup()
    return {
        Name              = '',
        Interval          = 0,
        IntervalIncrement = 0,
        ---public List{Event}
        Events            = {},
    }
end

local mt = {
    __call = function()
        return _EventGroup()
    end
}
setmetatable(mbg.EventGroup, mt)

function mbg.EventGroup.ParseFrom(c)
    local eg             = mbg.EventGroup()
    eg.Name              = mbg.ReadString(c, '|')
    eg.Interval          = mbg.ReadUInt(c, '|')
    eg.IntervalIncrement = mbg.ReadUInt(c, '|')
    eg.Events            = mbg.Event.ParseEvents(c)
    return eg
end

function mbg.EventGroup.ParseEventGroups(c)
    if not c or c:isempty() then
        return nil
    else
        local ret = {}
        local egs = c:split('&')
        SystemLog(c:tostring())
        SystemLog('#egs='..#egs)
        for _, v in ipairs(egs) do
            if v ~= '' then
                table.insert(ret, mbg.EventGroup.ParseFrom(String(v)))
            end
        end
        SystemLog('ret=\n\n'..stringify(ret))
        return ret
    end
end

