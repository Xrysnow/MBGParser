

mbg.MBGData = {
    Version      = '',
    TotalFrame   = 0,
    Center       = mbg.Center(),
    Layer1       = mbg.Layer(),
    Layer2       = mbg.Layer(),
    Layer3       = mbg.Layer(),
    Layer4       = mbg.Layer(),
    Sounds       = {},
    GlobalEvents = {},
}

function mbg.MBGData:ProcessNormalTitle(title, content, _mbg)
    local s = title:tostring()
    if s == 'Center' then
        self.Center = mbg.Center.ParseFromContent(content)
    elseif s == 'Totalframe' then
        self.TotalFrame = content:toint()
    elseif s == 'Layer1' then
        self.Layer1 = mbg.Layer.ParseFrom(content, _mbg)
    elseif s == 'Layer2' then
        self.Layer2 = mbg.Layer.ParseFrom(content, _mbg)
    elseif s == 'Layer3' then
        self.Layer3 = mbg.Layer.ParseFrom(content, _mbg)
    elseif s == 'Layer4' then
        self.Layer4 = mbg.Layer.ParseFrom(content, _mbg)
    else
        error("未知的标签:" .. title:tostring());
    end
end

function mbg.MBGData:ProcessNumberTitle(title, _mbg)
    if title:contains("Sounds") then
        self.Sounds = mbg.Sound.ParseSounds(title, _mbg)
        return true
    elseif title:contains("GlobalEvents") then
        self.GlobalEvents = mbg.GlobalEvents.ParseEvents(title, _mbg)
        return true
    end
    return false
end

function mbg.MBGData:GlobalEvent(title, _mbg)
    error('Not implemented.')
end

function mbg.MBGData.ParseFrom(mbgData)
    local _mbg = mbgData:copy()
    local data = mbg.MBGData()
    data.Version = _mbg:readline()

    if data.Version:tostring() ~= "Crazy Storm Data 1.01" then
        error("未知版本的CrazyStorm数据："..data.Version:tostring())
    end
    while _mbg:peek() ~= -1 do
        local content = _mbg:readline();
        if content and not content:isempty() then
            local title = mbg.ReadString(content, ':')

            local processed = data:ProcessNumberTitle(title, _mbg)
            if not processed then
                data:ProcessNormalTitle(title, content, _mbg)
            end
        end
    end
    return data
end

local function _MBGData()
    local ret              = {
        Version      = '',
        TotalFrame   = 0,
        Center       = mbg.Center(),
        Layer1       = mbg.Layer(),
        Layer2       = mbg.Layer(),
        Layer3       = mbg.Layer(),
        Layer4       = mbg.Layer(),
        Sounds       = {},
        GlobalEvents = {},
    }
    for k, v in pairs(mbg.MBGData) do
        ret[k] = v
    end
    return ret
end

local mt = {
    __call = function()
        return _MBGData()
    end
}
setmetatable(mbg.MBGData, mt)
