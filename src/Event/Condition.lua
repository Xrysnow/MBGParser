

mbg.Condition            = {}

mbg.Condition.Expression = {}

local mt_Expression      = {
    __call = function()
        return {
            LValue   = '',
            Operator = 0,
            RValue   = 0
        }
    end
}
setmetatable(mbg.Condition.Expression, mt_Expression)

mbg.Condition.Expression.OpType = {
    Greater = 0,
    Less    = 1,
    Equals  = 2
}

function mbg.Condition.Expression.ParseFrom(c)
    local e = mbg.Condition.Expression()
    if c:contains('>') then
        e.Operator = mbg.Condition.Expression.OpType.Greater
    elseif c:contains('<') then
        e.Operator = mbg.Condition.Expression.OpType.Less
    elseif c:contains('=') then
        e.Operator = mbg.Condition.Expression.OpType.Equals
    else
        error("未能解析表达式")
    end
    local values = c:split('>', '<', '=')
    e.LValue     = values[1]
    e.RValue     = tonumber(values[2])
    return e
end

mbg.Condition.SecondCondition             = {}

mbg.Condition.SecondCondition.LogicOpType = {
    And = 0,
    Or  = 1
}

local mt_SecondCondition                  = {
    __call = function()
        return {
            LogincOp = 0,
            Expr     = mbg.Condition.Expression()
        }
    end
}
setmetatable(mbg.Condition.SecondCondition, mt_SecondCondition)

local mt_Condition = {
    __call = function()
        return {
            First  = mbg.Condition.Expression(),
            Second = mbg.Condition.SecondCondition()
        }
    end
}
setmetatable(mbg.Condition, mt_Condition)

function mbg.Condition.ParseFrom(c)
    local op = nil
    if c:contains('且') then
        op = mbg.Condition.SecondCondition.LogicOpType.And
    elseif c:contains('或') then
        op = mbg.Condition.SecondCondition.LogicOpType.Or
    end
    local condition = mbg.Condition()
    if not op then
        condition.First  = mbg.Condition.Expression.ParseFrom(c)
        condition.Second = nil
    else
        local exprs               = c:split('且', '或')
        condition.First           = mbg.Condition.Expression.ParseFrom(String(exprs[1]))
        condition.Second          = mbg.Condition.SecondCondition()
        condition.Second.LogincOp = op
        condition.Second.Expr     = mbg.Condition.Expression.ParseFrom(String(exprs[2]))
    end
    return condition
end
