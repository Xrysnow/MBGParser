

mbg.DataOperateAction = {}

local function _DataOperateAction()
    return {
        LValue        = '',
        TweenTime     = 0,
        Times         = 0,
        RValue        = '',
        TweenFunction = 0,
        Operator      = 0
    }
end

local mt = {
    __call = function()
        return _DataOperateAction()
    end
}
setmetatable(mbg.DataOperateAction, mt)

mbg.DataOperateAction.TweenFunctionType = {
    Proportional = 0,
    Fixed        = 1,
    Sin          = 2
}

mbg.DataOperateAction.OperatorType      = {
    ChangeTo    = 0,
    Add         = 1,
    Subtraction = 2
}

local TweenFunctionType                 = mbg.DataOperateAction.TweenFunctionType

function mbg.DataOperateAction.ParseFrom(c)
    local sents = c:split('，')
    local d     = mbg.DataOperateAction()
    mbg.ActionHelper.ParseFirstSentence(String(sents[1]), d)
    local str = sents[2]
    if str == '固定' then
        d.TweenFunction = TweenFunctionType.Fixed
    elseif str == '正比' then
        d.TweenFunction = TweenFunctionType.Proportional
    elseif str == '正弦' then
        d.TweenFunction = TweenFunctionType.Sin
    else
        error("无法解析变化曲线名称: " .. sents[2])
    end
    local s3           = String(sents[3])
    local tweenTimeEnd = s3:find('帧')
    d.TweenTime        = s3:sub(1, tweenTimeEnd - 1):toint()
    d.Times            = nil
    local timesL       = s3:findlast('%(')
    local timesR       = s3:findlast('%)')
    if timesL ~= -1 and timesR ~= -1 then
        d.Times = s3:sub(timesL + 1, timesR - 1):toint()
    end
    return d
end

