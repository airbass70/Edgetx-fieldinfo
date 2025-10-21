--[[
================
==   FIELD    ==
================
Airbass70

Telemetry script per ottenere la descrizione completa ed il valore dei field di edgetx in funzione del loro metaindice.
Usare lo stick thr su e giu per cambiare l'indice
Ogni tanto ci sono delle posizioni vuote.
--]]

local Field_id			--metaindice del campo
local Field_name		--nome del campo
local field_desc		--descrizione del campo
local ThrId				--Metaindice dello stick thr
local t0				--lettura tempo dal precedente incremento/decremento dell'indice a
local t1				--lettura tempo da controllare 
local a					--indice da ottenere

local function init()
	--ottiene il metaindece dal campo thr. getFieldInfo restiruisce una tabella record da cui peschiamo il field name "id", oppure nil se non trova niente.
	ThrId = getFieldInfo("thr").id
	t0 = 0
	a=1					-- cambiare a piacimento per scandagliare più in alto
end

local function run ()
	--comanda indice a
	t1 = getTime()
	ThrVal = getValue(ThrId)	-- ottiene il valore di thr
	Speed=ThrVal/10000			--step per centesimo di secondo
	if ThrVal >0 and t1>t0+(1/Speed) then
		a=a+1
		t0=t1
	elseif ThrVal <0 and t1>t0+(1/Speed) then
		a=a-1
		t0=t1
	end
	
	lcd.clear()
	if getFieldInfo(a)==nil then
		lcd.drawText(10,10,tostring(a.." nil"),SMLSIZE)
	else	
		Field_id = getFieldInfo(a).id			--uguale a getFieldInfo(a)["id"]       ---	 	
		Field_name = getFieldInfo(a).name	--sintactic sugar per dati tipo record ---
		field_desc = getFieldInfo(a).desc		

		lcd.drawText(10,10,"id:",SMLSIZE)
		lcd.drawText(60,10,"val:",SMLSIZE)
		lcd.drawText(10,30,"name:",SMLSIZE)
		lcd.drawText(10,50,"Desc:",SMLSIZE)
		lcd.drawNumber(40,10,Field_id,SMLSIZE)
		lcd.drawText(40,30,Field_name,SMLSIZE)
		lcd.drawText(40,50,field_desc,SMLSIZE)
		lcd.drawText(90,10,tostring(getValue(Field_id)))
	end
end

return {run=run, init=init}
