-----------------------------------------------------------------------------------
-- Addon Name: KR Patch for Dolgubon's Lazy Writ Crafter
-- Original Addon: Dolgubon's Lazy Writ Crafter by Dolgubon (Joseph Heinzle)
--
-- File Name: DolgubonsLazyWritCreatorKRPatch.lua
-- File Description: Korean Localization
-- Load Order Requirements: After DolgubonsLazyWritCreator and EsoKR
--
-----------------------------------------------------------------------------------
--
-- Writ Crafter 4.0 부터 의뢰서 내용은 문구가 아니라 아이템 ID 로 판별된다.
-- 그래서 재료/부위/룬 이름 표나 langParser 같은 파싱용 번역은 더 이상 쓰이지 않고,
-- 원본의 Languages/en.lua 에 있는 항목만 번역하면 된다.
--
-- Vital 표시가 있는 문자열은 게임 내 한국어 문구와 정확히 일치해야 한다.
--
-----------------------------------------------------------------------------------

if EsoKR and EsoKR:isKorean() then
	WritCreater = WritCreater or {}

	function WritCreater.langWritNames() -- Vital
		-- Exact!!!  I know for german alchemy writ is Alchemistenschrieb - so ["G"] = schrieb, and ["A"]=Alchemisten
		local names = {
			["G"] = EsoKR:E("의뢰서를 확인한다."),
			[CRAFTING_TYPE_ENCHANTING] = EsoKR:E("마법부여가"),
			[CRAFTING_TYPE_BLACKSMITHING] = EsoKR:E("대장장이"),
			[CRAFTING_TYPE_CLOTHIER] = EsoKR:E("재봉사"),
			[CRAFTING_TYPE_PROVISIONING] = EsoKR:E("요리사"),
			[CRAFTING_TYPE_WOODWORKING] = EsoKR:E("목세공사"),
			[CRAFTING_TYPE_ALCHEMY] = EsoKR:E("연금술사"),
			[CRAFTING_TYPE_JEWELRYCRAFTING] = EsoKR:E("장신구"),
		}
		return names
	end

	-- 원본에 새 키가 추가되어도 nil 이 되지 않도록, 원본 값을 바탕으로 한국어만 덮어쓴다.
	local defaultWritCompleteStrings = WritCreater.writCompleteStrings

	function WritCreater.writCompleteStrings() -- Vital for translation
		local strings = defaultWritCompleteStrings and defaultWritCompleteStrings() or {}
		strings["place"] = EsoKR:E("<물건을 상자에 넣는다.>")
		strings["sign"] = EsoKR:E("<화물 목록에 서명합니다.>")
		strings["masterPlace"] = EsoKR:E("작업을 끝냈습니다.")
		strings["masterSign"] = EsoKR:E("<일을 끝마친다.>")
		strings["masterStart"] = EsoKR:E("<계약을 받아들인다.>")
		strings["Rolis Hlaalu"] = EsoKR:E("롤리스 흐랄루") -- This is the same in most languages but ofc chinese and japanese
		strings["Deliver"] = EsoKR:E("배달하기")
		return strings
	end

	function WritCreater.langStationNames() -- Vital for reticle changes
		return
		{[EsoKR:E("대장기술 제작대")] = 1, [EsoKR:E("재봉 제작대")] = 2,
		 [EsoKR:E("마법부여 제작대")] = 3,[EsoKR:E("연금술 제작대")] = 4, [EsoKR:E("요리용 화로")] = 5, [EsoKR:E("목공 제작대")] = 6, [EsoKR:E("장신구 제작대")] = 7, }
	end

	WritCreater.lang = EsoKR:getLanguage()

	WritCreater.strings["moreStyle"] 					= EsoKR:E("|cf60000사용 가능한 스타일 재료 없음.\n인벤토리나 설정을 확인|r")
end
