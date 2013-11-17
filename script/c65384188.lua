--実力伯仲
function c65384188.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c65384188.target)
	e1:SetOperation(c65384188.activate)
	c:RegisterEffect(e1)
end
function c65384188.filter(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsType(TYPE_EFFECT)
end
function c65384188.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c65384188.filter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingTarget(c65384188.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUPATTACK)
	Duel.SelectTarget(tp,c65384188.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUPATTACK)
	Duel.SelectTarget(tp,c65384188.filter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c65384188.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc1,tc2=Duel.GetFirstTarget()
	if tc1:IsRelateToEffect(e) and tc2:IsRelateToEffect(e) then
		c65384188.reg(c,tc1,tc2)
		c65384188.reg(c,tc2,tc1)
	end
end
function c65384188.reg(c,tc1,tc2)
	tc1:RegisterFlagEffect(65384188,RESET_EVENT+0x1fe0000,0,0)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHANGE_POS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetOperation(c65384188.posop)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	tc1:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetCondition(c65384188.effcon)
	e2:SetValue(1)
	e2:SetReset(RESET_EVENT+0x1fe0000)
	e2:SetLabelObject(tc2)
	tc1:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	tc1:RegisterEffect(e3)
	local e4=e2:Clone()
	e4:SetCode(EFFECT_CANNOT_ATTACK)
	tc1:RegisterEffect(e4)
	local e5=e2:Clone()
	e5:SetCode(EFFECT_IMMUNE_EFFECT)
	tc1:RegisterEffect(e5)
end
function c65384188.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetFlagEffect(65384188)~=0 and not c:IsPosition(POS_FACEUP_ATTACK) then
		c:ResetFlagEffect(65384188)
	end
end
function c65384188.effcon(e)
	return e:GetHandler():GetFlagEffect(65384188)~=0 and e:GetLabelObject():ResetFlagEffect(65384188)~=0
end