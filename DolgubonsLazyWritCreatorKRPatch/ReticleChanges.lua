if EsoKR and EsoKR:isKorean() then -- 추가
	WritCreater = WritCreater or {}
	function WritCreater.initializeReticleChanges()
		if not WritCreater.langStationNames then return end
		local stations = WritCreater.langStationNames()
		local originalReticleFunction = ZO_ReticleContainerInteractContext.SetText
		local deliverText = WritCreater.writCompleteStrings()["Deliver"]

		local function isQuestComplete(questIndex, numConditions)
			local numConditions = GetJournalQuestNumConditions(questIndex)
			for i = 1, numConditions do

				local cur, max =  GetJournalQuestConditionValues(questIndex,1,i)

				local s = GetJournalQuestConditionInfo(questIndex,1,i)

				if string.find(s, deliverText) then  return true
				end
			end
			return false
		end

		local function setupReplacement(object, functionName)

			local original = object[functionName]
			object[functionName] = function(self, text)
			-- If the setting is off exit

			if not WritCreater:GetSettings().changeReticle then  original(self, text) return end
				if type(text) ~= "string" then  original(self, text) return end -- 추가: removeIndex 는 문자열만 받는다
				text = EsoKR:removeIndex(text) -- 추가
			
				-- if not a station exit
				local craftingType = stations[text]
				if not craftingType then  original(self, text) return end

				-- Otherwise, do we have a writ on?
				local writs = WritCreater.writSearch()
				if writs[craftingType] then

					-- we have a writ. Do we need the reticle green or red
					if isQuestComplete(writs[craftingType]) or GetJournalQuestIsComplete(writs[craftingType]) then
						text = "|c66ff66"..text.."|r"
					else
						text = "|cff6666"..text.."|r"
					end

					original(self, text)
				else
					original(self, text)
				end
			end
		end

		setupReplacement(ZO_ReticleContainerInteractContext, "SetText")
	end

	-- 원본의 초기화가 이미 끝난 뒤에 이 파일이 로드됐다면, 원본은 재정의 전의 함수를 이미
	-- 호출했으므로 위 함수는 불리지 않는다. 그 경우에만 직접 한 번 적용한다.
	-- (초기화 전에 로드됐다면 원본이 위 함수를 호출해 준다.)
	if WritCreater.writNames then
		WritCreater.initializeReticleChanges()
	end
end --추가
