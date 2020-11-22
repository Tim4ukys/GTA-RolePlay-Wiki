script_name 'GTA RolePlay wiki'
script_author("Tim4ukys")
script_description("Большая инцеклопедия про Криминальную Россию и GTA RP")
script_url("https://vk.com/petrov_team")
script_version_number(21112020)
script_version('1.00')

local imgui = require 'imgui'
local KEY   = require 'vkeys'
local ini	= require 'inicfg'
local nameScript = thisScript().name

local imgui = require 'imgui'
local encoding = require 'encoding' -- загружаем библиотеку
encoding.default = 'CP1251' -- указываем кодировку по умолчанию, она должна совпадать с кодировкой файла. CP1251 - это Windows-1251
u8 = encoding.UTF8 -- и создаём короткий псевдоним для кодировщика UTF-8

local cfg = {
	Active = {
		Key = KEY.VK_NUMPAD0
	}
}

--Обнавление--
local dlstatus = require('moonloader').download_status
update_state = false

local script_vers = 1
local script_vers_text = "1.00"

local update_url = "https://raw.githubusercontent.com/Tim4ukys/GTA-RolePlay-Wiki/main/updateGTARPWiki.ini"
local update_path = getWorkingDirectory() .. "/updGTARolePlayWiki.ini"

local script_url = "https://github.com/Tim4ukys/GTA-RolePlay-Wiki/blob/main/bin/GTA_RP_Helper.luac?raw=true"
local script_path = thisScript().path

-- local script_image_url = ""
-- local script_image_path = getWorkingDirectory() .. "\\gta rp wiki\\img\\gtarp"

local show_obnavlen_yest = imgui.ImBool(false)
local show_obnavlen_zav = imgui.ImBool(false)
-----end------ 

-- Переменные --
local show_menu  = imgui.ImBool(false)
local show_ped   = imgui.ImBool(false)
local show_veh   = imgui.ImBool(false)
local show_weap  = imgui.ImBool(false)
-- local show_codes = imgui.ImBool(false)
local show_etc   = imgui.ImBool(false)
local show_samp  = imgui.ImBool(false)
local show_info  = imgui.ImBool(false)
local show_rp  = imgui.ImBool(false)
local show_pravila  = imgui.ImBool(false)
local show_zakonadatelstvo  = imgui.ImBool(false)
local show_gosorg  = imgui.ImBool(false)
local show_pro  = imgui.ImBool(false)
local show_prav_gos_volnu = imgui.ImBool(false)

local show_nelegorg  = imgui.ImBool(false)

local show_uerxuya = imgui.ImBool(false)

local show_nastrouka  = imgui.ImBool(false)

-- -------overlay--------
-- local show_overlay = imgui.ImBool(false)

-- local show_overlay_fps = imgui.ImBool(false)
-- local show_overlay_koor = imgui.ImBool(false)
-- local show_overlay_healh = imgui.ImBool(false)
-- local show_overlay_bronya = imgui.ImBool(false)
-- local show_overlay_time = imgui.ImBool(false)
-- -------end----------
-- local nastrouka_  = imgui.ImBool(false)
-- local nastrouka_  = imgui.ImBool(false)
-- local nastrouka_  = imgui.ImBool(false)
-- local nastrouka_  = imgui.ImBool(false)
-- local nastrouka_  = imgui.ImBool(false)
-- Фотки/Пруфы --
local image_nelegorg
local image_mesto_bizwar
local image_mesto_kapt_lut
local image_mesto_kapt_kor
local image_mesto_kapt_bys
local image_mesto_kapt_edo

local image_ierarhiya

local image_windows_gos_volna_1
local image_windows_gos_volna_2
local image_windows_gos_volna_3

local image_adm_priz
local image_adm_bat 
local image_pol_uzk 
local image_pol_arz
local image_gubdd
local image_bolka_uzk 
local image_bolka_arz
local image_smi 
local image_avtochkola 
local image_fsb
local image_amv
local image_vmf

local image_ut_mafia
local image_rus_mafia
local image_yakydza

local image_hadi_taktash
local image_tyap_lyap
local image_sykonka
local image_tykaevckie

local image_logo_authors
-- end --

local keyword   = imgui.ImBuffer('', 256)

local vehs = {
	F_S  = 'Sport',
	F_P  = 'SUVs & Pickup Trucks',
	F_L  = 'Lowriders',
	F_T  = 'Tuners',
	F_V  = 'Vans',
	F_I  = 'Industrial',
	F_C  = 'Coupes & Hatchbacks',
	F_E  = 'Sedans & Station Wagons',
	F_R  = 'Trains',
	F_U  = 'Public Service',
	F_N  = 'Novelty',
	F_G  = 'Government',
	F_A  = 'Aircraft',
	F_B  = 'Boats',
	F_M  = 'Motercycles & Bikes',
	F_RC = 'Remote Control',
	F_MS = 'Misc',
	F_TR = 'Trailers'
}

local veh_img  = {}
local ped_img  = {}
local weap_img = {}
local snp_img  = {}
local oys_img  = {}
local her_img  = {}
local KeyComboID = imgui.ImInt(0)

local ComboKeys = {}

function LoadSetting() -- Уёбищная загрузка. Внимание!!!! Кол-во опасного % говнокода зашкаливает!
	cfg = ini.load(cfg, string.gsub(nameScript, '.lua', ''))
	for v, k in pairs(KEY.key_names) do
		table.insert(ComboKeys, type(k) ~= 'table' and k or string.format('%s(%s)', k[1], k[2]))
	end
	table.sort(ComboKeys)
	local keyName = KEY.id_to_name(cfg.Active.Key)
	for v, k in pairs(ComboKeys) do
		if k == keyName then
			KeyComboID.v = v - 1
		end
	end
end

function SaveSetting()
	if not doesDirectoryExist("moonloader/config") 
		then
		createDirectory("moonloader/config")
	end
	ini.save(cfg, string.gsub(nameScript, '.lua', ''))
end

local SetStyle = ini.load({ -- Самый оптимизированый варик
  Style = 
  {
    StateStyle-- = 1 -- 6 max
  }, 
  Kor_OverLay =
  {
	x,-- = 512.0,
	y-- = 512.0
  },
  State_OverLay =
  {
	State_W,
	State_FPS,
	State_Healt,
	State_Koor,
	State_Time
  },
  Stroboskopu =
  {
	State
  }
})

------Стробоскопы--------
local show_strob_menu = imgui.ImBool(false)
local strob_state

if SetStyle.Stroboskopu.State == 1 then
	strob_state = true
else
	strob_state = false
end
----------End------------

-- if SetStyle.Style.StateStyle == 0 then 
-- 	SetStyle.Style.StateStyle = 1

-- 	SetStyle.Kor_OverLay.X = 512.0
-- 	SetStyle.Kor_OverLay.y = 512.0
-- 	ini.save(SetStyle)
-- end

-------overlay--------
local show_overlay
local show_overlay_fps
local show_overlay_healh
local show_overlay_koor
local show_overlay_time

if SetStyle.State_OverLay.State_W == 1 then
	show_overlay = imgui.ImBool(true)
else 
	show_overlay = imgui.ImBool(false)
end
if SetStyle.State_OverLay.State_FPS == 1 then
	show_overlay_fps = imgui.ImBool(true)
else 
	show_overlay_fps = imgui.ImBool(false)
end
if SetStyle.State_OverLay.State_Healt == 1 then
	show_overlay_healh = imgui.ImBool(true)
else 
	show_overlay_healh = imgui.ImBool(false)
end
if SetStyle.State_OverLay.State_Koor == 1 then
	show_overlay_koor = imgui.ImBool(true)
else 
	show_overlay_koor = imgui.ImBool(false)
end
if SetStyle.State_OverLay.State_Time == 1 then
	show_overlay_time = imgui.ImBool(true)
else
	show_overlay_time = imgui.ImBool(false)
end
---------end----------

-- Темы --
function temnobordovui() -- Темно-Бордовая тема
  imgui.SwitchContext()
  local style  = imgui.GetStyle()
  local colors = style.Colors
  local clr    = imgui.Col
  local ImVec4 = imgui.ImVec4

    style.FrameRounding    = 4.0
    style.GrabRounding     = 4.0

    colors[clr.Text]                 = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]         = ImVec4(0.73, 0.75, 0.74, 1.00)
    colors[clr.WindowBg]             = ImVec4(0.09, 0.09, 0.09, 0.94)
    colors[clr.ChildWindowBg]        = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.PopupBg]              = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.Border]               = ImVec4(0.20, 0.20, 0.20, 0.50)
    colors[clr.BorderShadow]         = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.FrameBg]              = ImVec4(0.71, 0.39, 0.39, 0.54)
    colors[clr.FrameBgHovered]       = ImVec4(0.84, 0.66, 0.66, 0.40)
    colors[clr.FrameBgActive]        = ImVec4(0.84, 0.66, 0.66, 0.67)
    colors[clr.TitleBg]              = ImVec4(0.47, 0.22, 0.22, 0.67)
    colors[clr.TitleBgActive]        = ImVec4(0.47, 0.22, 0.22, 1.00)
    colors[clr.TitleBgCollapsed]     = ImVec4(0.47, 0.22, 0.22, 0.67)
    colors[clr.MenuBarBg]            = ImVec4(0.34, 0.16, 0.16, 1.00)
    colors[clr.ScrollbarBg]          = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]        = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabHovered] = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.ScrollbarGrabActive]  = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.CheckMark]            = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.SliderGrab]           = ImVec4(0.71, 0.39, 0.39, 1.00)
    colors[clr.SliderGrabActive]     = ImVec4(0.84, 0.66, 0.66, 1.00)
    colors[clr.Button]               = ImVec4(0.47, 0.22, 0.22, 0.65)
    colors[clr.ButtonHovered]        = ImVec4(0.71, 0.39, 0.39, 0.65)
    colors[clr.ButtonActive]         = ImVec4(0.20, 0.20, 0.20, 0.50)
    colors[clr.Header]               = ImVec4(0.71, 0.39, 0.39, 0.54)
    colors[clr.HeaderHovered]        = ImVec4(0.84, 0.66, 0.66, 0.65)
    colors[clr.HeaderActive]         = ImVec4(0.84, 0.66, 0.66, 0.00)
    colors[clr.Separator]            = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.SeparatorHovered]     = ImVec4(0.71, 0.39, 0.39, 0.54)
    colors[clr.SeparatorActive]      = ImVec4(0.71, 0.39, 0.39, 0.54)
    colors[clr.ResizeGrip]           = ImVec4(0.71, 0.39, 0.39, 0.54)
    colors[clr.ResizeGripHovered]    = ImVec4(0.84, 0.66, 0.66, 0.66)
    colors[clr.ResizeGripActive]     = ImVec4(0.84, 0.66, 0.66, 0.66)
    colors[clr.CloseButton]          = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.CloseButtonHovered]   = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]    = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotLines]            = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]     = ImVec4(1.00, 0.43, 0.35, 1.00)
    colors[clr.PlotHistogram]        = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.TextSelectedBg]       = ImVec4(0.26, 0.59, 0.98, 0.35)
    colors[clr.ModalWindowDarkening] = ImVec4(0.80, 0.80, 0.80, 0.35)
end

function temnokrasn() -- Темно-Красная тема
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    local ImVec2 = imgui.ImVec2

    style.WindowPadding = imgui.ImVec2(8, 8)
    style.WindowRounding = 6
    style.ChildWindowRounding = 5
    style.FramePadding = imgui.ImVec2(5, 3)
    style.FrameRounding = 3.0
    style.ItemSpacing = imgui.ImVec2(5, 4)
    style.ItemInnerSpacing = imgui.ImVec2(4, 4)
    style.IndentSpacing = 21
    style.ScrollbarSize = 10.0
    style.ScrollbarRounding = 13
    style.GrabMinSize = 8
    style.GrabRounding = 1
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)

    colors[clr.Text]                   = ImVec4(0.95, 0.96, 0.98, 1.00);
    colors[clr.TextDisabled]           = ImVec4(0.29, 0.29, 0.29, 1.00);
    colors[clr.WindowBg]               = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.ChildWindowBg]          = ImVec4(0.12, 0.12, 0.12, 1.00);
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94);
    colors[clr.Border]                 = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.BorderShadow]           = ImVec4(1.00, 1.00, 1.00, 0.10);
    colors[clr.FrameBg]                = ImVec4(0.22, 0.22, 0.22, 1.00);
    colors[clr.FrameBgHovered]         = ImVec4(0.18, 0.18, 0.18, 1.00);
    colors[clr.FrameBgActive]          = ImVec4(0.09, 0.12, 0.14, 1.00);
    colors[clr.TitleBg]                = ImVec4(0.14, 0.14, 0.14, 0.81);
    colors[clr.TitleBgActive]          = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51);
    colors[clr.MenuBarBg]              = ImVec4(0.20, 0.20, 0.20, 1.00);
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.39);
    colors[clr.ScrollbarGrab]          = ImVec4(0.36, 0.36, 0.36, 1.00);
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.18, 0.22, 0.25, 1.00);
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.24, 0.24, 0.24, 1.00);
    colors[clr.ComboBg]                = ImVec4(0.24, 0.24, 0.24, 1.00);
    colors[clr.CheckMark]              = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.SliderGrab]             = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.SliderGrabActive]       = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.Button]                 = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.ButtonHovered]          = ImVec4(1.00, 0.39, 0.39, 1.00);
    colors[clr.ButtonActive]           = ImVec4(1.00, 0.21, 0.21, 1.00);
    colors[clr.Header]                 = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.HeaderHovered]          = ImVec4(1.00, 0.39, 0.39, 1.00);
    colors[clr.HeaderActive]           = ImVec4(1.00, 0.21, 0.21, 1.00);
    colors[clr.ResizeGrip]             = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.ResizeGripHovered]      = ImVec4(1.00, 0.39, 0.39, 1.00);
    colors[clr.ResizeGripActive]       = ImVec4(1.00, 0.19, 0.19, 1.00);
    colors[clr.CloseButton]            = ImVec4(0.40, 0.39, 0.38, 0.16);
    colors[clr.CloseButtonHovered]     = ImVec4(0.40, 0.39, 0.38, 0.39);
    colors[clr.CloseButtonActive]      = ImVec4(0.40, 0.39, 0.38, 1.00);
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00);
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00);
    colors[clr.PlotHistogram]          = ImVec4(1.00, 0.21, 0.21, 1.00);
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.18, 0.18, 1.00);
    colors[clr.TextSelectedBg]         = ImVec4(1.00, 0.32, 0.32, 1.00);
    colors[clr.ModalWindowDarkening]   = ImVec4(0.26, 0.26, 0.26, 0.60);
end

function temno_oransh() -- Темно-Оранжевая тема
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    local ImVec2 = imgui.ImVec2

    style.WindowRounding         = 4.0
    style.WindowTitleAlign       = ImVec2(0.5, 0.5)
    style.ChildWindowRounding    = 2.0
    style.FrameRounding          = 2.0
    style.ItemSpacing            = ImVec2(10, 5)
    style.ScrollbarSize          = 15
    style.ScrollbarRounding      = 0
    style.GrabMinSize            = 9.6
    style.GrabRounding           = 1.0
    style.WindowPadding          = ImVec2(10, 10)
    style.AntiAliasedLines       = true
    style.AntiAliasedShapes      = true
    style.FramePadding           = ImVec2(5, 4)
    style.DisplayWindowPadding   = ImVec2(27, 27)
    style.DisplaySafeAreaPadding = ImVec2(5, 5)
    style.ButtonTextAlign        = ImVec2(0.5, 0.5)

    colors[clr.Text]                 = ImVec4(0.92, 0.92, 0.92, 1.00)
    colors[clr.TextDisabled]         = ImVec4(0.44, 0.44, 0.44, 1.00)
    colors[clr.WindowBg]             = ImVec4(0.06, 0.06, 0.06, 1.00)
    colors[clr.ChildWindowBg]        = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.PopupBg]              = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]              = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.Border]               = ImVec4(0.51, 0.36, 0.15, 1.00)
    colors[clr.BorderShadow]         = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.FrameBg]              = ImVec4(0.11, 0.11, 0.11, 1.00)
    colors[clr.FrameBgHovered]       = ImVec4(0.51, 0.36, 0.15, 1.00)
    colors[clr.FrameBgActive]        = ImVec4(0.78, 0.55, 0.21, 1.00)
    colors[clr.TitleBg]              = ImVec4(0.51, 0.36, 0.15, 1.00)
    colors[clr.TitleBgActive]        = ImVec4(0.91, 0.64, 0.13, 1.00)
    colors[clr.TitleBgCollapsed]     = ImVec4(0.00, 0.00, 0.00, 0.51)
    colors[clr.MenuBarBg]            = ImVec4(0.11, 0.11, 0.11, 1.00)
    colors[clr.ScrollbarBg]          = ImVec4(0.06, 0.06, 0.06, 0.53)
    colors[clr.ScrollbarGrab]        = ImVec4(0.21, 0.21, 0.21, 1.00)
    colors[clr.ScrollbarGrabHovered] = ImVec4(0.47, 0.47, 0.47, 1.00)
    colors[clr.ScrollbarGrabActive]  = ImVec4(0.81, 0.83, 0.81, 1.00)
    colors[clr.CheckMark]            = ImVec4(0.78, 0.55, 0.21, 1.00)
    colors[clr.SliderGrab]           = ImVec4(0.91, 0.64, 0.13, 1.00)
    colors[clr.SliderGrabActive]     = ImVec4(0.91, 0.64, 0.13, 1.00)
    colors[clr.Button]               = ImVec4(0.51, 0.36, 0.15, 1.00)
    colors[clr.ButtonHovered]        = ImVec4(0.91, 0.64, 0.13, 1.00)
    colors[clr.ButtonActive]         = ImVec4(0.78, 0.55, 0.21, 1.00)
    colors[clr.Header]               = ImVec4(0.51, 0.36, 0.15, 1.00)
    colors[clr.HeaderHovered]        = ImVec4(0.91, 0.64, 0.13, 1.00)
    colors[clr.HeaderActive]         = ImVec4(0.93, 0.65, 0.14, 1.00)
    colors[clr.Separator]            = ImVec4(0.21, 0.21, 0.21, 1.00)
    colors[clr.SeparatorHovered]     = ImVec4(0.91, 0.64, 0.13, 1.00)
    colors[clr.SeparatorActive]      = ImVec4(0.78, 0.55, 0.21, 1.00)
    colors[clr.ResizeGrip]           = ImVec4(0.21, 0.21, 0.21, 1.00)
    colors[clr.ResizeGripHovered]    = ImVec4(0.91, 0.64, 0.13, 1.00)
    colors[clr.ResizeGripActive]     = ImVec4(0.78, 0.55, 0.21, 1.00)
    colors[clr.CloseButton]          = ImVec4(0.47, 0.47, 0.47, 1.00)
    colors[clr.CloseButtonHovered]   = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]    = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotLines]            = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]     = ImVec4(1.00, 0.43, 0.35, 1.00)
    colors[clr.PlotHistogram]        = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.TextSelectedBg]       = ImVec4(0.26, 0.59, 0.98, 0.35)
    colors[clr.ModalWindowDarkening] = ImVec4(0.80, 0.80, 0.80, 0.35)
end

function black_grey() -- Светло-Серая тема
  imgui.SwitchContext()
  local style = imgui.GetStyle()
  local colors = style.Colors
  local clr = imgui.Col
  local ImVec4 = imgui.ImVec4
  local ImVec2 = imgui.ImVec2

  style.FramePadding = ImVec2(4.0, 2.0)
  style.ItemSpacing = ImVec2(8.0, 2.0)
  style.WindowRounding = 1.0
  style.FrameRounding = 1.0
  style.ScrollbarRounding = 1.0
  style.GrabRounding = 1.0

  colors[clr.Text] = ImVec4(1.00, 1.00, 1.00, 0.95)
  colors[clr.TextDisabled] = ImVec4(0.50, 0.50, 0.50, 1.00)
  colors[clr.WindowBg] = ImVec4(0.13, 0.12, 0.12, 1.00)
  colors[clr.ChildWindowBg] = ImVec4(0.13, 0.12, 0.12, 1.00)
  colors[clr.PopupBg] = ImVec4(0.05, 0.05, 0.05, 0.94)
  colors[clr.Border] = ImVec4(0.53, 0.53, 0.53, 0.46)
  colors[clr.BorderShadow] = ImVec4(0.00, 0.00, 0.00, 0.00)
  colors[clr.FrameBg] = ImVec4(0.00, 0.00, 0.00, 0.85)
  colors[clr.FrameBgHovered] = ImVec4(0.22, 0.22, 0.22, 0.40)
  colors[clr.FrameBgActive] = ImVec4(0.16, 0.16, 0.16, 0.53)
  colors[clr.TitleBg] = ImVec4(0.00, 0.00, 0.00, 1.00)
  colors[clr.TitleBgActive] = ImVec4(0.00, 0.00, 0.00, 1.00)
  colors[clr.TitleBgCollapsed] = ImVec4(0.00, 0.00, 0.00, 0.51)
  colors[clr.MenuBarBg] = ImVec4(0.12, 0.12, 0.12, 1.00)
  colors[clr.ScrollbarBg] = ImVec4(0.02, 0.02, 0.02, 0.53)
  colors[clr.ScrollbarGrab] = ImVec4(0.31, 0.31, 0.31, 1.00)
  colors[clr.ScrollbarGrabHovered] = ImVec4(0.41, 0.41, 0.41, 1.00)
  colors[clr.ScrollbarGrabActive] = ImVec4(0.48, 0.48, 0.48, 1.00)
  colors[clr.ComboBg] = ImVec4(0.24, 0.24, 0.24, 0.99)
  colors[clr.CheckMark] = ImVec4(0.79, 0.79, 0.79, 1.00)
  colors[clr.SliderGrab] = ImVec4(0.48, 0.47, 0.47, 0.91)
  colors[clr.SliderGrabActive] = ImVec4(0.56, 0.55, 0.55, 0.62)
  colors[clr.Button] = ImVec4(0.50, 0.50, 0.50, 0.63)
  colors[clr.ButtonHovered] = ImVec4(0.67, 0.67, 0.68, 0.63)
  colors[clr.ButtonActive] = ImVec4(0.26, 0.26, 0.26, 0.63)
  colors[clr.Header] = ImVec4(0.54, 0.54, 0.54, 0.58)
  colors[clr.HeaderHovered] = ImVec4(0.64, 0.65, 0.65, 0.80)
  colors[clr.HeaderActive] = ImVec4(0.25, 0.25, 0.25, 0.80)
  colors[clr.Separator] = ImVec4(0.58, 0.58, 0.58, 0.50)
  colors[clr.SeparatorHovered] = ImVec4(0.81, 0.81, 0.81, 0.64)
  colors[clr.SeparatorActive] = ImVec4(0.81, 0.81, 0.81, 0.64)
  colors[clr.ResizeGrip] = ImVec4(0.87, 0.87, 0.87, 0.53)
  colors[clr.ResizeGripHovered] = ImVec4(0.87, 0.87, 0.87, 0.74)
  colors[clr.ResizeGripActive] = ImVec4(0.87, 0.87, 0.87, 0.74)
  colors[clr.CloseButton] = ImVec4(0.45, 0.45, 0.45, 0.50)
  colors[clr.CloseButtonHovered] = ImVec4(0.70, 0.70, 0.90, 0.60)
  colors[clr.CloseButtonActive] = ImVec4(0.70, 0.70, 0.70, 1.00)
  colors[clr.PlotLines] = ImVec4(0.68, 0.68, 0.68, 1.00)
  colors[clr.PlotLinesHovered] = ImVec4(0.68, 0.68, 0.68, 1.00)
  colors[clr.PlotHistogram] = ImVec4(0.90, 0.77, 0.33, 1.00)
  colors[clr.PlotHistogramHovered] = ImVec4(0.87, 0.55, 0.08, 1.00)
  colors[clr.TextSelectedBg] = ImVec4(0.47, 0.60, 0.76, 0.47)
  colors[clr.ModalWindowDarkening] = ImVec4(0.88, 0.88, 0.88, 0.35)
end

function StandartTheme() -- Стандартный стиль
	imgui.SwitchContext()
	local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col
	local ImVec4 = imgui.ImVec4
	style.WindowRounding = 2.0
	style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
	style.ChildWindowRounding = 2.0
	style.FrameRounding = 2.0
	style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
	style.ScrollbarSize = 13.0
	style.ScrollbarRounding = 0
	style.GrabMinSize = 8.0
	style.GrabRounding = 1.0
	colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
	colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
	colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
	colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
	colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
	colors[clr.ComboBg]                = colors[clr.PopupBg]
	colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
	colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
	colors[clr.FrameBg]                = ImVec4(0.16, 0.29, 0.48, 0.54)
	colors[clr.FrameBgHovered]         = ImVec4(0.26, 0.59, 0.98, 0.40)
	colors[clr.FrameBgActive]          = ImVec4(0.26, 0.59, 0.98, 0.67)
	colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
	colors[clr.TitleBgActive]          = ImVec4(0.16, 0.29, 0.48, 1.00)
	colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
	colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
	colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
	colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
	colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
	colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
	colors[clr.CheckMark]              = ImVec4(0.26, 0.59, 0.98, 1.00)
	colors[clr.SliderGrab]             = ImVec4(0.24, 0.52, 0.88, 1.00)
	colors[clr.SliderGrabActive]       = ImVec4(0.26, 0.59, 0.98, 1.00)
	colors[clr.Button]                 = ImVec4(0.26, 0.59, 0.98, 0.40)
	colors[clr.ButtonHovered]          = ImVec4(0.26, 0.59, 0.98, 1.00)
	colors[clr.ButtonActive]           = ImVec4(0.06, 0.53, 0.98, 1.00)
	colors[clr.Header]                 = ImVec4(0.26, 0.59, 0.98, 0.31)
	colors[clr.HeaderHovered]          = ImVec4(0.26, 0.59, 0.98, 0.80)
	colors[clr.HeaderActive]           = ImVec4(0.26, 0.59, 0.98, 1.00)
	colors[clr.Separator]              = colors[clr.Border]
	colors[clr.SeparatorHovered]       = ImVec4(0.26, 0.59, 0.98, 0.78)
	colors[clr.SeparatorActive]        = ImVec4(0.26, 0.59, 0.98, 1.00)
	colors[clr.ResizeGrip]             = ImVec4(0.26, 0.59, 0.98, 0.25)
	colors[clr.ResizeGripHovered]      = ImVec4(0.26, 0.59, 0.98, 0.67)
	colors[clr.ResizeGripActive]       = ImVec4(0.26, 0.59, 0.98, 0.95)
	colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
	colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
	colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
	colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
	colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
	colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
	colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
	colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.59, 0.98, 0.35)
	colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
end

function CherryTheme() -- Вишнёвый стиль
  imgui.SwitchContext()
  local style = imgui.GetStyle()
  local colors = style.Colors
  local clr = imgui.Col
  local ImVec4 = imgui.ImVec4
  local ImVec2 = imgui.ImVec2


  style.WindowPadding = ImVec2(6, 4)
  style.WindowRounding = 0.0
  style.FramePadding = ImVec2(5, 2)
  style.FrameRounding = 3.0
  style.ItemSpacing = ImVec2(7, 1)
  style.ItemInnerSpacing = ImVec2(1, 1)
  style.TouchExtraPadding = ImVec2(0, 0)
  style.IndentSpacing = 6.0
  style.ScrollbarSize = 12.0
  style.ScrollbarRounding = 16.0
  style.GrabMinSize = 20.0
  style.GrabRounding = 2.0

  style.WindowTitleAlign = ImVec2(0.5, 0.5)

  colors[clr.Text] = ImVec4(0.860, 0.930, 0.890, 0.78)
  colors[clr.TextDisabled] = ImVec4(0.860, 0.930, 0.890, 0.28)
  colors[clr.WindowBg] = ImVec4(0.13, 0.14, 0.17, 1.00)
  colors[clr.ChildWindowBg] = ImVec4(0.200, 0.220, 0.270, 0.58)
  colors[clr.PopupBg] = ImVec4(0.200, 0.220, 0.270, 0.9)
  colors[clr.Border] = ImVec4(0.31, 0.31, 1.00, 0.00)
  colors[clr.BorderShadow] = ImVec4(0.00, 0.00, 0.00, 0.00)
  colors[clr.FrameBg] = ImVec4(0.200, 0.220, 0.270, 1.00)
  colors[clr.FrameBgHovered] = ImVec4(0.455, 0.198, 0.301, 0.78)
  colors[clr.FrameBgActive] = ImVec4(0.455, 0.198, 0.301, 1.00)
  colors[clr.TitleBg] = ImVec4(0.232, 0.201, 0.271, 1.00)
  colors[clr.TitleBgActive] = ImVec4(0.502, 0.075, 0.256, 1.00)
  colors[clr.TitleBgCollapsed] = ImVec4(0.200, 0.220, 0.270, 0.75)
  colors[clr.MenuBarBg] = ImVec4(0.200, 0.220, 0.270, 0.47)
  colors[clr.ScrollbarBg] = ImVec4(0.200, 0.220, 0.270, 1.00)
  colors[clr.ScrollbarGrab] = ImVec4(0.09, 0.15, 0.1, 1.00)
  colors[clr.ScrollbarGrabHovered] = ImVec4(0.455, 0.198, 0.301, 0.78)
  colors[clr.ScrollbarGrabActive] = ImVec4(0.455, 0.198, 0.301, 1.00)
  colors[clr.CheckMark] = ImVec4(0.71, 0.22, 0.27, 1.00)
  colors[clr.SliderGrab] = ImVec4(0.47, 0.77, 0.83, 0.14)
  colors[clr.SliderGrabActive] = ImVec4(0.71, 0.22, 0.27, 1.00)
  colors[clr.Button] = ImVec4(0.47, 0.77, 0.83, 0.14)
  colors[clr.ButtonHovered] = ImVec4(0.455, 0.198, 0.301, 0.86)
  colors[clr.ButtonActive] = ImVec4(0.455, 0.198, 0.301, 1.00)
  colors[clr.Header] = ImVec4(0.455, 0.198, 0.301, 0.76)
  colors[clr.HeaderHovered] = ImVec4(0.455, 0.198, 0.301, 0.86)
  colors[clr.HeaderActive] = ImVec4(0.502, 0.075, 0.256, 1.00)
  colors[clr.ResizeGrip] = ImVec4(0.47, 0.77, 0.83, 0.04)
  colors[clr.ResizeGripHovered] = ImVec4(0.455, 0.198, 0.301, 0.78)
  colors[clr.ResizeGripActive] = ImVec4(0.455, 0.198, 0.301, 1.00)
  colors[clr.PlotLines] = ImVec4(0.860, 0.930, 0.890, 0.63)
  colors[clr.PlotLinesHovered] = ImVec4(0.455, 0.198, 0.301, 1.00)
  colors[clr.PlotHistogram] = ImVec4(0.860, 0.930, 0.890, 0.63)
  colors[clr.PlotHistogramHovered] = ImVec4(0.455, 0.198, 0.301, 1.00)
  colors[clr.TextSelectedBg] = ImVec4(0.455, 0.198, 0.301, 0.43)
  colors[clr.ModalWindowDarkening] = ImVec4(0.200, 0.220, 0.270, 0.73)
  colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
  colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
  colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
end

if SetStyle.Style.StateStyle == 1 then
	temnobordovui()
elseif SetStyle.Style.StateStyle == 2 then
	temnokrasn()
elseif SetStyle.Style.StateStyle == 3 then
	temno_oransh()
elseif SetStyle.Style.StateStyle == 4 then
	black_grey()
elseif SetStyle.Style.StateStyle == 5 then
	StandartTheme()
elseif SetStyle.Style.StateStyle == 6 then
	CherryTheme()
end
-- CherryTheme()

-- end --


local Wheather_St = imgui.ImInt(1)

function imgui.OnDrawFrame()
	if show_menu.v then
		local sw, sh = getScreenResolution()
		imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.Begin('GTA RP Wiki', imgui.ImVec2(210, 200), imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.MenuBar)
				imgui.PushItemWidth(100)
				if imgui.Combo(u8'Клавиша Активации', KeyComboID, ComboKeys)
				then
					cfg.Active.Key = KEY.name_to_id(ComboKeys[KeyComboID.v + 1] , false )
				end
				imgui.PopItemWidth()
				imgui.BeginMenuBar()
					if imgui.BeginMenu(u8'Меню') then
						if imgui.MenuItem(u8'Показывать это меню в игровом меню') then
							imgui.RenderInMenu = not imgui.RenderInMenu
						end
						if imgui.MenuItem(u8'Информация') then
							show_info.v = not show_info.v
						end
						if imgui.MenuItem(u8'Стробоскопы') then
							show_strob_menu.v = not show_strob_menu.v
						end
						if imgui.MenuItem(u8'Настройки') then
							show_nastrouka.v = not show_nastrouka.v
						end 
					imgui.EndMenu()
					end
				imgui.EndMenuBar()
				if imgui.Button(u8'Скины', imgui.ImVec2(70.0, 50.0)) then
					show_ped.v = not show_ped.v
				end
				imgui.SameLine()
				if imgui.Button(u8'Транспорт', imgui.ImVec2(80.0, 50.0)) then
					show_veh.v = not show_veh.v
				end
				imgui.SameLine()
				if imgui.Button(u8'Оружие', imgui.ImVec2(70.0, 50.0)) then
					show_weap.v = not show_weap.v
				end
			-- if imgui.Button('Cheat-Codes', imgui.ImVec2(-0.1, 25.0)) then
				-- show_codes.v = not show_codes.v
			-- end
			if imgui.Button(u8'Локации', imgui.ImVec2(-0.1, 25.0)) then
				show_etc.v = not show_etc.v
			end
			if imgui.Button('Criminal Russia Multiplayer', imgui.ImVec2(-0.1, 25.0)) then			
				show_samp.v = not show_samp.v
			end
			if imgui.Button(u8'RP Термины', imgui.ImVec2(-0.1, 25.0)) then
				show_rp.v = not show_rp.v
			end 
			if imgui.Button(u8'Правила', imgui.ImVec2(-0.1, 25.0)) then
				show_pravila.v = not show_pravila.v
			end
			if imgui.Button(u8'Гос. организациям', imgui.ImVec2(-0.1, 25.0)) then
				show_gosorg.v = not show_gosorg.v
			end
			if imgui.Button(u8'Нелег. организациям', imgui.ImVec2(-0.1, 25.0)) then
				show_nelegorg.v = not show_nelegorg.v
			end
		imgui.End()
		if show_strob_menu.v then
			-- local sw, sh = getScreenResolution()
			-- imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			-- imgui.SetNextWindowSize(imgui.ImVec2(210, 80), imgui.Cond.FirstUseEver)
			imgui.Begin(u8'Стробоскопы', show_strob_menu, imgui.WindowFlags.AlwaysAutoResize)
				if imgui.Button(u8"Включить", imgui.ImVec2(80.0, 50.0)) then 
					strob_state = true
					SetStyle.Stroboskopu.State = 1
					ini.save(SetStyle)
				end
				imgui.SameLine()
				if imgui.Button(u8"Выключить", imgui.ImVec2(80.0, 50.0)) then 
					strob_state = false
					SetStyle.Stroboskopu.State = 0
					ini.save(SetStyle)
				end
			imgui.End()
		end
		if show_nelegorg.v then
			local sw, sh = getScreenResolution()
			imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.SetNextWindowSize(imgui.ImVec2(557, 500), imgui.Cond.FirstUseEver)
			imgui.Begin(u8'Нелег. организациям', show_nelegorg)
				if imgui.CollapsingHeader(u8'Правила каптов')
				then
					ImFileParse('\\gta rp wiki\\gtarp\\neleg_org\\pravkapt.txt', nil, nil, 'pattern')
				end
				if imgui.CollapsingHeader(u8'Правила бизваров')
				then
					ImFileParse('\\gta rp wiki\\gtarp\\neleg_org\\pravbuzwar.txt', nil, nil, 'pattern')
				end
				if imgui.CollapsingHeader(u8'Места для проведения Бизваров/Каптов') 
				then
					imgui.Text(u8' Бизвары между Мафиями могут проходить только в указанном ниже месте:')
					if imgui.TreeNode(u8'Место') then
						imgui.Text(u8'  Находится к югу от "КАД"')
						imgui.Image(image_mesto_bizwar, imgui.ImVec2(512, 512))
						imgui.TreePop()
					end
					imgui.Text(u8'\n Всего есть 4 места где можно проводить капты для ОПГ. Если вы выйдите за')
					imgui.Text(u8' красную линию, вы получите деморган. Во время капта можно разойтись по всему ')
					imgui.Text(u8' гетто. Но не выходя за его границы.')
					if imgui.TreeNode(u8'Места') then
						imgui.Text(u8'  1) Лыткарино')
						imgui.Text(u8'  ')
						imgui.SameLine()
						imgui.Image(image_mesto_kapt_lut, imgui.ImVec2(512, 512))
						imgui.Text(u8'  2) Корякино')
						imgui.Text(u8'  ')
						imgui.SameLine()
						imgui.Image(image_mesto_kapt_kor, imgui.ImVec2(512, 356))
						imgui.Text(u8'  3) Бусаево')
						imgui.Text(u8'  ')
						imgui.SameLine()
						imgui.Image(image_mesto_kapt_bys, imgui.ImVec2(512, 356))
						imgui.Text(u8'  4) Эдово')
						imgui.Text(u8'  ')
						imgui.SameLine()
						imgui.Image(image_mesto_kapt_edo, imgui.ImVec2(512, 512))
						imgui.TreePop()
					end
				end
				imgui.Text('\n')
				imgui.Separator()
				imgui.Text('')
				imgui.Image(image_nelegorg, imgui.ImVec2(556, 156))
			imgui.End()
		end
		if show_ped.v then
			local sw, sh = getScreenResolution()
			imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.SetNextWindowSize(imgui.ImVec2(460, 500), imgui.Cond.FirstUseEver)
			imgui.Begin(u8'Персонажи/Скины', show_ped)
				ImFileParse('\\gta rp wiki\\peds.txt', imgui.ImVec2(55, 100), ped_img, 'ID: (%d+)')
			imgui.End()
		end
		if show_veh.v then
			local sw, sh = getScreenResolution()
			imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.SetNextWindowSize(imgui.ImVec2(460, 500), imgui.Cond.FirstUseEver)
			imgui.Begin(u8'Транспортные средства', show_veh)
			-- for k, v in pairs(vehs) do
			-- 	if imgui.TreeNode(v) then
			-- 		ImFileParse('\\gta rp wiki\\vehicles\\'..v..'.txt', imgui.ImVec2(175, 100), veh_img, u8'т/с: (%d+)')
			-- 		imgui.TreePop()
			-- 	end
			-- end
				if imgui.TreeNode(u8"Воздушный транспорт") then
					ImFileParse('\\gta rp wiki\\vehicles\\Aircraft.txt', imgui.ImVec2(175, 100), veh_img, u8'т/с: (%d+)')
					imgui.TreePop()
				end
				if imgui.TreeNode(u8"Водный транспорт") then
					ImFileParse('\\gta rp wiki\\vehicles\\Boats.txt', imgui.ImVec2(175, 100), veh_img, u8'т/с: (%d+)')
					imgui.TreePop()
				end
				if imgui.TreeNode(u8'"Купе" и "Хэтчбеки"') then
					ImFileParse('\\gta rp wiki\\vehicles\\Coupes & Hatchbacks.txt', imgui.ImVec2(175, 100), veh_img, u8'т/с: (%d+)')
					imgui.TreePop()
				end
				if imgui.TreeNode(u8"Правительственный транспорт") then
					ImFileParse('\\gta rp wiki\\vehicles\\Government.txt', imgui.ImVec2(175, 100), veh_img, u8'т/с: (%d+)')
					imgui.TreePop()
				end
				if imgui.TreeNode(u8"Промышленный транспорт") then
					ImFileParse('\\gta rp wiki\\vehicles\\Industrial.txt', imgui.ImVec2(175, 100), veh_img, u8'т/с: (%d+)')
					imgui.TreePop()
				end
				if imgui.TreeNode(u8"Лоурайдер`s") then
					ImFileParse('\\gta rp wiki\\vehicles\\Lowriders.txt', imgui.ImVec2(175, 100), veh_img, u8'т/с: (%d+)')
					imgui.TreePop()
				end
				if imgui.TreeNode(u8"Мотоциклы и Велосипеды") then
					ImFileParse('\\gta rp wiki\\vehicles\\Motercycles & Bikes.txt', imgui.ImVec2(175, 100), veh_img, u8'т/с: (%d+)')
					imgui.TreePop()
				end
				if imgui.TreeNode(u8"Необычный транспорт") then
					ImFileParse('\\gta rp wiki\\vehicles\\Novelty.txt', imgui.ImVec2(175, 100), veh_img, u8'т/с: (%d+)')
					imgui.TreePop()
				end
				if imgui.TreeNode(u8"Рабочий транспорт") then
					ImFileParse('\\gta rp wiki\\vehicles\\Public Service.txt', imgui.ImVec2(175, 100), veh_img, u8'т/с: (%d+)')
					imgui.TreePop()
				end
				if imgui.TreeNode(u8"RС-игрушки") then
					ImFileParse('\\gta rp wiki\\vehicles\\Remote Control.txt', imgui.ImVec2(175, 100), veh_img, u8'т/с: (%d+)')
					imgui.TreePop()
				end
				if imgui.TreeNode(u8'"Седаны" И "Универсалы"') then
					ImFileParse('\\gta rp wiki\\vehicles\\Sedans & Station Wagons.txt', imgui.ImVec2(175, 100), veh_img, u8'т/с: (%d+)')
					imgui.TreePop()
				end
				if imgui.TreeNode(u8"СпортКары") then
					ImFileParse('\\gta rp wiki\\vehicles\\Sport.txt', imgui.ImVec2(175, 100), veh_img, u8'т/с: (%d+)')
					imgui.TreePop()
				end
				if imgui.TreeNode(u8'"Внедорожники" И "Пикапы"') then
					ImFileParse('\\gta rp wiki\\vehicles\\SUVs & Pickup Trucks.txt', imgui.ImVec2(175, 100), veh_img, u8'т/с: (%d+)')
					imgui.TreePop()
				end
				if imgui.TreeNode(u8"Прицепы") then
					ImFileParse('\\gta rp wiki\\vehicles\\Trailers.txt', imgui.ImVec2(175, 100), veh_img, u8'т/с: (%d+)')
					imgui.TreePop()
				end
				if imgui.TreeNode(u8"Поезда") then
					ImFileParse('\\gta rp wiki\\vehicles\\Trains.txt', imgui.ImVec2(175, 100), veh_img, u8'т/с: (%d+)')
					imgui.TreePop()
				end
				if imgui.TreeNode(u8"Автомобили с обвесом") then
					ImFileParse('\\gta rp wiki\\vehicles\\Tuners.txt', imgui.ImVec2(175, 100), veh_img, u8'т/с: (%d+)')
					imgui.TreePop()
				end
				if imgui.TreeNode(u8"Фургоны") then
					ImFileParse('\\gta rp wiki\\vehicles\\Vans.txt', imgui.ImVec2(175, 100), veh_img, u8'т/с: (%d+)')
					imgui.TreePop()
				end
				if imgui.TreeNode(u8"Другое") then
					ImFileParse('\\gta rp wiki\\vehicles\\Misc.txt', imgui.ImVec2(175, 100), veh_img, u8'т/с: (%d+)')
					imgui.TreePop()
				end
			imgui.End()
		end
		if show_weap.v then
			local sw, sh = getScreenResolution()
			imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.SetNextWindowSize(imgui.ImVec2(460, 500), imgui.Cond.FirstUseEver)
			imgui.Begin(u8'Оружие', show_weap)
				ImFileParse('\\gta rp wiki\\weapons.txt', imgui.ImVec2(50,50), weap_img, 'ID: (%d+)')
			imgui.End()
		end
		-- if show_codes.v then
			-- imgui.SetNextWindowSize(imgui.ImVec2(460, 500), imgui.Cond.FirstUseEver)
			-- imgui.Begin('Cheat-Codes', show_codes)
				-- ImFileParse('\\sa wiki\\cheat-codes.txt', nil, nil, 'pattern')
			-- imgui.End()
		-- end
		if show_etc.v then
			local sw, sh = getScreenResolution()
			imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.SetNextWindowSize(imgui.ImVec2(460, 500), imgui.Cond.FirstUseEver)
			imgui.Begin(u8'Локации', show_etc)
				-- if imgui.TreeNode(u8'Важные места') then
				-- 	-- ImFileParse('\\gta rp wiki\\etc\\Snapshots.txt', imgui.ImVec2(225, 169), snp_img, '(%d+).')
				-- 	imgui.TreePop()
				-- end
				-- if imgui.TreeNode(u8'Бизнесы') then
				-- 	ImFileParse('\\gta rp wiki\\etc\\Snapshots.txt', imgui.ImVec2(225, 169), snp_img, '(%d+).')
				-- 	imgui.TreePop()
				-- end
				Loka()
			imgui.End()
		end
		if show_info.v then
			local sw, sh = getScreenResolution()
			imgui.SetNextWindowPos(imgui.ImVec2(sw / 2 + 200, sh / 2 - 150), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.Begin(u8'Информация', show_info, imgui.WindowFlags.AlwaysAutoResize)
				imgui.Text(u8'Автор: Tim4ukys\nГруппа по GTA RP: Petrov Team\nВерсия: '..thisScript().version) -- Кто это отредактирует
				imgui.Separator()
				imgui.Text(u8'Информация:\nДанный скрипт призван облегчить работу Администрации проекта GTA RP,')
				imgui.Text(u8'Гос. Сотрудникам, Бандитам и простым игрокам проекта GTA RolePlay.')
				imgui.Text(u8'У каждого была ситуация(допустим), когда лидер ФСБ на вербовке,')
				imgui.Text(u8'спрашивает статью УкРФ, которую в обычной игре используется 1% и')
				imgui.Text(u8'конечно же ты её забыл, с этим скриптом можно просто нажать')
				imgui.Text(u8'на клавишу, быстро освежить память и не создавать нелепых ситуаций.')
				imgui.Text(u8'Так же администратор перед мп может не лезть на форум, а просто')
				imgui.Text(u8'залезть в этот хелпер и выбрать автомобиль или скин.')
				imgui.Text(u8'\nЕсли вам скрипт действительно понравился, то прошу подписаться на мою группу')
				imgui.Text(u8'Petrov Team и рассказать о ней друзьям.\nЭто будет самая лучшая благодарность за мои труды:)')
				imgui.Separator()
				imgui.Text(u8'Связь:')
				imgui.Text(u8'Ник в игре: Vasiliy_Katasi\nНомер: 44-14-14\nСервер: 02')
				imgui.Text(u8'VK - vk.com/tim4ukys')
				imgui.Text(u8'VK groups - vk.com/petrov_team')
				imgui.Separator()
				imgui.Text(u8'Спасибо веб-страницам:\nwiki.sa-mp.com\nforum.gtarp.ru\nblast.hk') -- и это, тот педрила ;)
				imgui.Text(u8'Отдельное спасибо моему другу "Rich_Zloy" за помощь =)')
				imgui.Text(' ')
				imgui.Image(image_logo_authors, imgui.ImVec2(512,176))
			imgui.End()
		end
		if show_samp.v then
			local sw, sh = getScreenResolution()
			imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.SetNextWindowSize(imgui.ImVec2(950, 350), imgui.Cond.FirstUseEver)
			imgui.Begin('Criminal Russia Multiplayer', show_samp)
				if imgui.CollapsingHeader(u8'Команды')
				then
					ImFileParse('\\gta rp wiki\\crmp\\commands.txt', nil, nil, 'pattern')
				end
				if imgui.CollapsingHeader(u8'Настройки (sa-mp.cfg)')
				then
					ImFileParse('\\gta rp wiki\\crmp\\settings.txt', nil, nil, 'pattern')
				end
			imgui.End()
		end
		if show_rp.v then
			local sw, sh = getScreenResolution()
			imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.SetNextWindowSize(imgui.ImVec2(650, 450), imgui.Cond.FirstUseEver)
			imgui.Begin(u8'RolePlay Термины', show_rp)
				ImFileParse('\\gta rp wiki\\gtarp\\rpterms.txt', nil, nil, 'rppat')
			imgui.End()
		end 
		if show_pravila.v then
			local sw, sh = getScreenResolution()
			imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.SetNextWindowSize(imgui.ImVec2(730, 500), imgui.Cond.FirstUseEver)
			imgui.Begin(u8'Правила', show_pravila)
				if imgui.CollapsingHeader(u8'Общие правила проекта') then
					ImFileParse('\\gta rp wiki\\gtarp\\obshpravila.txt', nil, nil, 'obshpravilapat')
				end
				if imgui.CollapsingHeader(u8'Правила обращения в репорт') then
					ImFileParse('\\gta rp wiki\\gtarp\\obshpravilavrep.txt', nil, nil, 'obshpravilavreppat')
				end
				if imgui.CollapsingHeader(u8'Правила использования голосового чата') then
					ImFileParse('\\gta rp wiki\\gtarp\\obshpravilausevicechat.txt', nil, nil, 'obshpravilausevicechatpat')
				end
				if imgui.CollapsingHeader(u8'Правила войны семей и ограблений банка') then
					ImFileParse('\\gta rp wiki\\gtarp\\obshpravilawarfam.txt', nil, nil, 'obshpravilawarfampat')
				end
			imgui.End()
		end 
		if show_nastrouka.v then
			local sw, sh = getScreenResolution()
			imgui.SetNextWindowPos(imgui.ImVec2(sw / 2 - 200, sh / 2 - 50), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.Begin(u8'Настройки', show_nastrouka, imgui.WindowFlags.AlwaysAutoResize)
				-- SetStyle.Style.StateStyle == 1
				if imgui.Button(u8'Стандартный стиль', imgui.ImVec2(280.0, 30.0)) then
					StandartTheme()
					SetStyle.Style.StateStyle = 5
					ini.save(SetStyle)
				end
				if imgui.Button(u8'Вишнёвый стиль', imgui.ImVec2(280.0, 30.0)) then
					CherryTheme()
					SetStyle.Style.StateStyle = 6
					ini.save(SetStyle)
				end
				if imgui.Button(u8'Светло-Серая тема', imgui.ImVec2(280.0, 30.0)) then
					black_grey()
					SetStyle.Style.StateStyle = 4
					ini.save(SetStyle)
				end 
				if imgui.Button(u8'Темно-Оранжевая тема', imgui.ImVec2(280.0, 30.0)) then 
					temno_oransh()
					SetStyle.Style.StateStyle = 3
					ini.save(SetStyle)
				end 
				if imgui.Button(u8'Темно-Красная тема', imgui.ImVec2(280.0, 30.0)) then
					temnokrasn()
					SetStyle.Style.StateStyle = 2
					ini.save(SetStyle)
				end 
				if imgui.Button(u8'Темно-Бордовая тема', imgui.ImVec2(280.0, 30.0)) then
					temnobordovui()
					SetStyle.Style.StateStyle = 1
					ini.save(SetStyle)
				end 

				-- temnobordovui
				-- temnokrasn
				-- temno_oransh
				-- black_grey
				-- StandartTheme
				-- CherryTheme

				-- SetStyle.State_OverLay.State_W
				-- SetStyle.State_OverLay.State_FPS
				-- SetStyle.State_OverLay.State_Healt
				-- SetStyle.State_OverLay.State_Koor
				imgui.Separator()
				if imgui.SliderInt(u8"Погода", Wheather_St, 1, 45) then
					-- forceWeatherNow(tonumber(Wheather_St))
				end
				imgui.Text(string.format(u8"Погода - %d", tonumber(Wheather_St.v)))
				forceWeatherNow(tonumber(Wheather_St.v))
				imgui.Separator()
				if imgui.Checkbox("Overlay", show_overlay) then
					SetStyle.State_OverLay.State_W = 1
					ini.save(SetStyle)
				end
				if show_overlay.v then
					imgui.Text(' ')
					imgui.SameLine()
					if imgui.Checkbox('FPS', show_overlay_fps) then -- show_overlay_fps show_overlay_koor show_overlay_healh
						SetStyle.State_OverLay.State_FPS = 1
						ini.save(SetStyle)
					end
					imgui.Text(' ')
					imgui.SameLine()
					if imgui.Checkbox(u8'Координаты игрока', show_overlay_koor) then
						SetStyle.State_OverLay.State_Koor = 1
						ini.save(SetStyle)
					end
					imgui.Text(' ')
					imgui.SameLine()
					if imgui.Checkbox(u8'Здоровье и броня игрока', show_overlay_healh) then
						SetStyle.State_OverLay.State_Healt = 1
						ini.save(SetStyle)
					end
					imgui.Text(' ')
					imgui.SameLine()
					if imgui.Checkbox(u8'Дата и время', show_overlay_time) then 
						SetStyle.State_OverLay.State_Time = 1
						ini.save(SetStyle)
					end
				end
			imgui.End()
		end
		if show_gosorg.v then
			local sw, sh = getScreenResolution()
			imgui.SetNextWindowPos(imgui.ImVec2(sw / 2 + 200, sh / 2 + 100), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			-- imgui.SetNextWindowSize(imgui.ImVec2(730, 500), imgui.Cond.FirstUseEver)
			imgui.Begin(u8'Гос. организациям', show_gosorg)
				if imgui.Button(u8'Законодательство', imgui.ImVec2(300.0, 25.0)) then
					show_zakonadatelstvo.v = not show_zakonadatelstvo.v
				end
				if imgui.Button(u8'Правила редактирования объявлений', imgui.ImVec2(300.0, 25.0)) then
					show_pro.v = not show_pro.v
				end
				if imgui.Button(u8'Иерархия должностей гос. структур', imgui.ImVec2(300.0, 25.0)) then
					show_uerxuya.v = not show_uerxuya.v
				end
				if imgui.Button(u8'Правила гос. волны', imgui.ImVec2(300.0, 25.0)) then 
					show_prav_gos_volnu.v = not show_prav_gos_volnu.v
				end
			imgui.End()
			if show_uerxuya.v then
				local sw, sh = getScreenResolution()
				imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
				imgui.SetNextWindowSize(imgui.ImVec2(730, 500), imgui.Cond.FirstUseEver)
				imgui.Begin(u8'Иерархия должностей гос. структур', show_uerxuya)
					-- local colors = style.Colors
					-- local clr    = imgui.Col
					Uearhuya()
				imgui.End()
			end
			if show_zakonadatelstvo.v then
				local sw, sh = getScreenResolution()
				imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
				imgui.SetNextWindowSize(imgui.ImVec2(730, 500), imgui.Cond.FirstUseEver)
				imgui.Begin(u8'Законодательство РФ', show_zakonadatelstvo)
					if imgui.CollapsingHeader(u8'Уголовный кодекс(Ук.РФ)') then
						ImFileParse('\\gta rp wiki\\gtarp\\gos_org\\zakon\\ykrf.txt', nil, nil, 'ykrfpat')
					end
					if imgui.CollapsingHeader(u8'Федеральное постановление(ФП)') then
						ImFileParse('\\gta rp wiki\\gtarp\\gos_org\\zakon\\fp.txt', nil, nil, 'fppat')
					end
					if imgui.CollapsingHeader(u8'КоАП') then
						ImFileParse('\\gta rp wiki\\gtarp\\gos_org\\zakon\\koap.txt', nil, nil, 'koappat')
					end
				imgui.End()
			end
			if show_pro.v then
				local sw, sh = getScreenResolution()
				imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
				imgui.SetNextWindowSize(imgui.ImVec2(730, 500), imgui.Cond.FirstUseEver)
				-- imgui.SetNextWindowSize(imgui.ImVec2(460, 500), imgui.Cond.FirstUseEver)
				imgui.Begin(u8'Правила редактирования объявлений(П.Р.О)', show_pro)
					ImFileParse('\\gta rp wiki\\gtarp\\gos_org\\pro.txt', nil, nil, 'propat')
				imgui.End()
			end
			if show_prav_gos_volnu.v then 
				local sw, sh = getScreenResolution()
				imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
				imgui.SetNextWindowSize(imgui.ImVec2(650, 550), imgui.Cond.FirstUseEver)
				imgui.Begin(u8"Правила государственной волны", show_prav_gos_volnu)
					-- imgui.Text(u8'Привет, мир!');
					-- imgui.Text(u8"",...)
					-- imgui.Text(" ")
					GosVolna()
				imgui.End()
			end
		end
	end
	-- Оверлей --
	if show_overlay.v == true and show_overlay_fps.v or show_overlay.v == true and show_overlay_koor.v or show_overlay.v == true and show_overlay_healh.v or show_overlay.v == true and show_overlay_time.v then
		-- local sw, sh = getScreenResolution()
		imgui.SetNextWindowPos(imgui.ImVec2(SetStyle.Kor_OverLay.x + 20, SetStyle.Kor_OverLay.y + 20), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		-- imgui.PushStyleVarFloat(imgui.StyleVar.Alpha,0.65)
		-- imgui.PushStyleVarFloat(imgui.StyleVar.Alpha,0.65)
		imgui.Begin('Overlay', show_overlay, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoFocusOnAppearing)
			if show_overlay_fps.v then
				imgui.Text(string.format('FPS: %d', imgui.GetIO().Framerate))
			end
			if show_overlay_koor.v then
				local positionX, positionY, positionZ = getCharCoordinates(PLAYER_PED)
				imgui.Text(string.format(u8'Координаты: X - "%d"; Y - "%d"; Z - "%d";', positionX, positionY, positionZ))
			end
			if show_overlay_healh.v then
				-- getCharHealth(Ped ped)
				local bronya = getCharArmour(PLAYER_PED)
				if bronya <= 0 then
					imgui.Text(string.format('HP - "%d"', getCharHealth(PLAYER_PED)))
				else
					imgui.Text(string.format('HP - "%d" | Armour - "%d"', getCharHealth(PLAYER_PED), bronya))
				end
			end
			if show_overlay_time.v then
				imgui.Text(string.format(u8'Время - %s:%s | Дата - %s', os.date("%H", os.time()), os.date("%M", os.time()), os.date("%x")))
			end
			local pos = imgui.GetWindowPos()
			SetStyle.Kor_OverLay.x = pos.x
			SetStyle.Kor_OverLay.y = pos.y
			ini.save(SetStyle)
		imgui.End()
	end
	-- end --

	-- Обнавление --
	if show_obnavlen_yest.v then
		local sw, sh = getScreenResolution()
		imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(u8'Обновление', show_obnavlen_yest, imgui.WindowFlags.AlwaysAutoResize)
			obnavlenue_yes()
		imgui.End()
	end

	if show_obnavlen_zav.v then
		local sw, sh = getScreenResolution()
		imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(u8'Обновление', show_obnavlen_zav, imgui.WindowFlags.AlwaysAutoResize)
			obnavlenue_zav()
		imgui.End()
	end
	-- end --
end

function obnavlenue_yes()
	imgui.Text(u8"Вышло обновление скрипта GTA RP Wiki\nЧтобы продолжить, нажмите на одну из кнопок: Да/Нет.\n")
	imgui.Text(u8'Во время обнавления возможны вылеты\nи зависания игры. Если игра зависнет более\n5 минут, закрывайте игру и заходите в неё обратно.\n')
	imgui.Text(string.format(u8'%s', updateIni.info.infa_update)) -- updateIni.info.vers
	if imgui.Button(u8"Да", imgui.ImVec2(150.0, 50.0)) then 
		os.remove(update_path)
		update_state = true
		show_obnavlen_yest.v = not show_obnavlen_yest.v
	end
	imgui.SameLine()
	if imgui.Button(u8"Нет", imgui.ImVec2(150.0, 50.0)) then 
		os.remove(update_path)
		show_obnavlen_yest.v = not show_obnavlen_yest.v
	end
end

function obnavlenue_zav()
	imgui.Text(u8"Скрипт обнавляется! Приятной игры на GTA RolePlay\n(c) Tim4ukys")
end

function main()
	-- local anotherIni = inicfg.load(nil, "example_another_config")
	-- если файл был успешно загружен
	-- if anotherIni ~= nil then
		-- if
			
		-- end
	-- else
		-- CherryTheme()
	-- end
	image_adm_priz = imgui.CreateTextureFromFile(string.format('%s\\gta rp wiki\\img\\gtarp\\adm_priz.png', getWorkingDirectory()))
	image_adm_bat = imgui.CreateTextureFromFile(string.format('%s\\gta rp wiki\\img\\gtarp\\adm_bat.png', getWorkingDirectory()))
	image_pol_uzk = imgui.CreateTextureFromFile(string.format('%s\\gta rp wiki\\img\\gtarp\\pol_uznogo.png', getWorkingDirectory()))
	image_pol_arz = imgui.CreateTextureFromFile(string.format('%s\\gta rp wiki\\img\\gtarp\\pol_arz.png', getWorkingDirectory()))
	image_gubdd = imgui.CreateTextureFromFile(string.format('%s\\gta rp wiki\\img\\gtarp\\gubdd.png', getWorkingDirectory()))
	image_bolka_uzk = imgui.CreateTextureFromFile(string.format('%s\\gta rp wiki\\img\\gtarp\\bolka_uzka.png', getWorkingDirectory()))
	image_bolka_arz = imgui.CreateTextureFromFile(string.format('%s\\gta rp wiki\\img\\gtarp\\bolka_arz.png', getWorkingDirectory()))
	image_smi = imgui.CreateTextureFromFile(string.format('%s\\gta rp wiki\\img\\gtarp\\smi.png', getWorkingDirectory()))
	image_avtochkola = imgui.CreateTextureFromFile(string.format('%s\\gta rp wiki\\img\\gtarp\\avtohkola.png', getWorkingDirectory()))
	image_fsb = imgui.CreateTextureFromFile(string.format('%s\\gta rp wiki\\img\\gtarp\\fsb.png', getWorkingDirectory()))


	image_mesto_bizwar = imgui.CreateTextureFromFile(string.format('%s\\gta rp wiki\\img\\gtarp\\mesto_bizwar.png', getWorkingDirectory()))
	image_nelegorg = imgui.CreateTextureFromFile(string.format('%s\\gta rp wiki\\img\\gtarp\\neleg_org.png', getWorkingDirectory()))
	image_mesto_kapt_lut = imgui.CreateTextureFromFile(string.format('%s\\gta rp wiki\\img\\gtarp\\mesto_kapt_lut.png', getWorkingDirectory()))
	image_mesto_kapt_kor = imgui.CreateTextureFromFile(string.format('%s\\gta rp wiki\\img\\gtarp\\mesto_kapt_kor.png', getWorkingDirectory()))
	image_mesto_kapt_edo = imgui.CreateTextureFromFile(string.format('%s\\gta rp wiki\\img\\gtarp\\mesto_kapt_edo.png', getWorkingDirectory()))
	image_mesto_kapt_bys = imgui.CreateTextureFromFile(string.format('%s\\gta rp wiki\\img\\gtarp\\mesto_kapt_bys.png', getWorkingDirectory()))
	image_ierarhiya = imgui.CreateTextureFromFile(string.format('%s\\gta rp wiki\\img\\gtarp\\ierarhiya.png', getWorkingDirectory()))
	image_amv = imgui.CreateTextureFromFile(string.format('%s\\gta rp wiki\\img\\gtarp\\amv.png', getWorkingDirectory()))
	image_vmf = imgui.CreateTextureFromFile(string.format('%s\\gta rp wiki\\img\\gtarp\\vmf.png', getWorkingDirectory()))
	image_ut_mafia = imgui.CreateTextureFromFile(string.format('%s\\gta rp wiki\\img\\gtarp\\ut_mafia.png', getWorkingDirectory()))
	image_rus_mafia = imgui.CreateTextureFromFile(string.format('%s\\gta rp wiki\\img\\gtarp\\rus_mafia.png', getWorkingDirectory()))
	image_yakydza = imgui.CreateTextureFromFile(string.format('%s\\gta rp wiki\\img\\gtarp\\yakydza.png', getWorkingDirectory()))
	image_hadi_taktash = imgui.CreateTextureFromFile(string.format('%s\\gta rp wiki\\img\\gtarp\\hadi_taktash.png', getWorkingDirectory()))
	image_tyap_lyap = imgui.CreateTextureFromFile(string.format('%s\\gta rp wiki\\img\\gtarp\\tyap_lyap.png', getWorkingDirectory()))
	image_sykonka = imgui.CreateTextureFromFile(string.format('%s\\gta rp wiki\\img\\gtarp\\sykonka.png', getWorkingDirectory()))
	image_tykaevckie = imgui.CreateTextureFromFile(string.format('%s\\gta rp wiki\\img\\gtarp\\tykaevckie.png', getWorkingDirectory()))

	image_logo_authors = imgui.CreateTextureFromFile(string.format('%s\\gta rp wiki\\img\\logo_avtor.png', getWorkingDirectory()))

	image_windows_gos_volna_1 = imgui.CreateTextureFromFile(string.format('%s\\gta rp wiki\\img\\gtarp\\windows_gos_volna_1.png', getWorkingDirectory()))
	image_windows_gos_volna_2 = imgui.CreateTextureFromFile(string.format('%s\\gta rp wiki\\img\\gtarp\\windows_gos_volna_2.png', getWorkingDirectory()))
	image_windows_gos_volna_3 = imgui.CreateTextureFromFile(string.format('%s\\gta rp wiki\\img\\gtarp\\windows_gos_volna_3.png', getWorkingDirectory()))

	ped_img  		= fillImgTable(0, 299, '\\gta rp wiki\\img\\ped\\Skin_')
	weap_img 		= fillImgTable(0, 46, '\\gta rp wiki\\img\\weap\\')
	veh_img  		= fillImgTable(400, 798, '\\gta rp wiki\\img\\veh\\Vehicle_') -- 613
	snp_img  		= fillImgTable(0, 50,'\\gta rp wiki\\img\\Snapshots\\')
	oys_img  		= fillImgTable(0, 50, '\\gta rp wiki\\img\\Oysters\\')
	her_img  		= fillImgTable(0, 50, '\\gta rp wiki\\img\\Herses\\')
	-- imgui.MouseDrawCursor = imBool(false)
	-- imgui.SetMouseCursor(0)

	lua_thread.create(strobe)
	lua_thread.create(strobeText)

	--Обновление--

	-- local script_vers = 1
	-- local script_vers_text = "1.00"
	
	-- local update_url = ""
	-- local update_path = getWorkingDirectory() .. "/updGTARolePlayWiki.ini"
	
	-- local script_url = ""
	-- local script_path = thisScript().path

	downloadUrlToFile(update_url, update_path, function(id, status)
		if status == dlstatus.STATUS_ENDDOWNLOADDATA then
			updateIni = ini.load(nil, update_path)
			if not updateIni ~= nil then 
				if tonumber(updateIni.info.vers) > script_vers then
					-- printStringNow('Yest obnavlenue', 2000)
					show_obnavlen_yest.v = not show_obnavlen_yest.v
				else
					os.remove(update_path)
				end
			end
		end
	end)
	------end-----

	while true do
		if wasKeyPressed(cfg.Active.Key) then show_menu.v = not show_menu.v end
		if show_menu.v == false and show_overlay.v == false then imgui.Process = show_menu.v end
		if show_menu.v == true and show_overlay.v == false then imgui.Process = show_menu.v end
		if show_menu.v == true and show_overlay.v == true then imgui.Process = show_menu.v end
		if show_menu.v == false and show_overlay.v == true then imgui.Process = show_overlay.v end
		imgui.ShowCursor = show_menu.v
		if show_obnavlen_yest.v then imgui.ShowCursor = show_obnavlen_yest.v end
		wait(0)

		--Обновление--
		if update_state then 
			downloadUrlToFile(script_url, script_path, function(id, status)
				if status == dlstatus.STATUS_ENDDOWNLOADDATA then
					show_obnavlen_zav.v = not show_obnavlen_zav.v
					imgui.Process = false
					thisScript():reload()
				end
			end)
			break
		end
		------end-----

		---------СТРОБОСКОПЫ-----------
		if isCharInAnyCar(PLAYER_PED) and strob_state == true then
		
			local car = storeCarCharIsInNoSave(PLAYER_PED)
			local driverPed = getDriverOfCar(car)
			
			if isKeyDown(VK_LMENU) and driverPed == PLAYER_PED and strob_state == true then
				local state = true
				
				for i = 1, 10 do
					wait(100)
					if not isKeyDown(VK_LMENU) then state = false end
				end
				
				if isKeyDown(VK_LMENU) and state then
					
					local state = not isCarSirenOn(car)
					switchCarSiren(car, state)
					
					while isKeyDown(VK_LMENU) do wait(0) end
				
				end
				
			end
			
		end
		-------------End---------------
	end
end







---------СТРОБОСКОПЫ-----------
function stroboscopes(adress, ptr, _1, _2, _3, _4)
	if not isCharInAnyCar(PLAYER_PED) then return end
	
	if not isCarSirenOn(storeCarCharIsInNoSave(PLAYER_PED)) then
		forceCarLights(storeCarCharIsInNoSave(PLAYER_PED), 0)
		callMethod(7086336, ptr, 2, 0, 1, 3)
		callMethod(7086336, ptr, 2, 0, 0, 0)
		callMethod(7086336, ptr, 2, 0, 1, 0)
		markCarAsNoLongerNeeded(storeCarCharIsInNoSave(PLAYER_PED)) 
		return
	end

	callMethod(adress, ptr, _1, _2, _3, _4)
end

function strobeText()
	local sequence = true
	while true do
		wait(0)
		if isCharInAnyCar(PLAYER_PED) then
		
			local car = storeCarCharIsInNoSave(PLAYER_PED)
			local driverPed = getDriverOfCar(car)
			
			if isCarSirenOn(car) and PLAYER_PED == driverPed then
				
				-- if sequence then printStyledString('~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~b~STROB~w~OS~r~COPES', 1000, 4)
				-- else printStyledString('~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~r~STROB~w~OS~b~COPES', 1000, 4) end
				
				sequence = not sequence
				wait(950)
				
			end
		end
	end
end

function strobe()
	while true do
		wait(0)
		
		if isCharInAnyCar(PLAYER_PED) then
		
			local car = storeCarCharIsInNoSave(PLAYER_PED)
			local driverPed = getDriverOfCar(car)
			
			if isCarSirenOn(car) and PLAYER_PED == driverPed and strob_state == true then
			
				local ptr = getCarPointer(car) + 1440
				forceCarLights(car, 2)
				wait(50)
				stroboscopes(7086336, ptr, 2, 0, 1, 3)

				while isCarSirenOn(car) do
					wait(0)
					for i = 1, 12 do
						wait(100)
						stroboscopes(7086336, ptr, 2, 0, 1, 0)
						wait(100)
						stroboscopes(7086336, ptr, 2, 0, 0, 0)
						stroboscopes(7086336, ptr, 2, 0, 1, 1)
						wait(100)
						stroboscopes(7086336, ptr, 2, 0, 0, 1)
						stroboscopes(7086336, ptr, 2, 0, 1, 0)
						wait(100)
						stroboscopes(7086336, ptr, 2, 0, 1, 0)
						stroboscopes(7086336, ptr, 2, 0, 1, 1)
						if not isCarSirenOn(car) or not isCharInAnyCar(PLAYER_PED) or strob_state == false then break end
					end
					
					if not isCarSirenOn(car) or not isCharInAnyCar(PLAYER_PED) or strob_state == false then break end

					for i = 1, 6 do
						wait(80)
						stroboscopes(7086336, ptr, 2, 0, 1, 3)
						stroboscopes(7086336, ptr, 2, 0, 0, 0)
						wait(80)
						stroboscopes(7086336, ptr, 2, 0, 1, 0)
						wait(80)
						stroboscopes(7086336, ptr, 2, 0, 0, 0)
						wait(80)
						stroboscopes(7086336, ptr, 2, 0, 1, 0)
						if not isCarSirenOn(car) or not isCharInAnyCar(PLAYER_PED) or strob_state == false then break end
						wait(300)
						stroboscopes(7086336, ptr, 2, 0, 0, 1)
						wait(80)
						stroboscopes(7086336, ptr, 2, 0, 1, 1)
						wait(80)
						stroboscopes(7086336, ptr, 2, 0, 0, 1)
						wait(80)
						stroboscopes(7086336, ptr, 2, 0, 1, 1)
						if not isCarSirenOn(car) or not isCharInAnyCar(PLAYER_PED) or strob_state == false then break end
					end
					
					if not isCarSirenOn(car) or not isCharInAnyCar(PLAYER_PED) or strob_state == false then break end

					for i = 1, 3 do
						wait(60)
						stroboscopes(7086336, ptr, 2, 0, 1, 3)
						stroboscopes(7086336, ptr, 2, 0, 1, 0)
						stroboscopes(7086336, ptr, 2, 0, 0, 1)
						wait(60)
						stroboscopes(7086336, ptr, 2, 0, 1, 1)
						wait(60)
						stroboscopes(7086336, ptr, 2, 0, 0, 1)
						wait(60)
						stroboscopes(7086336, ptr, 2, 0, 1, 1)
						wait(60)
						stroboscopes(7086336, ptr, 2, 0, 0, 1)
						wait(60)
						stroboscopes(7086336, ptr, 2, 0, 1, 1)
						wait(60)
						stroboscopes(7086336, ptr, 2, 0, 0, 0)
						wait(60)
						if not isCarSirenOn(car) or not isCharInAnyCar(PLAYER_PED) or strob_state == false then break end
						stroboscopes(7086336, ptr, 2, 0, 1, 0)
						wait(60)
						stroboscopes(7086336, ptr, 2, 0, 0, 0)
						wait(350)
						stroboscopes(7086336, ptr, 2, 0, 1, 0)
						stroboscopes(7086336, ptr, 2, 0, 0, 1)
						wait(60)
						if not isCarSirenOn(car) or not isCharInAnyCar(PLAYER_PED) or strob_state == false then break end
						stroboscopes(7086336, ptr, 2, 0, 1, 1)
						stroboscopes(7086336, ptr, 2, 0, 0, 0)
						wait(50)
						stroboscopes(7086336, ptr, 2, 0, 1, 0)
						stroboscopes(7086336, ptr, 2, 0, 0, 1)
						wait(50)
						stroboscopes(7086336, ptr, 2, 0, 1, 1)
						stroboscopes(7086336, ptr, 2, 0, 0, 0)
						wait(100)
						stroboscopes(7086336, ptr, 2, 0, 1, 1)
						stroboscopes(7086336, ptr, 2, 0, 1, 1)
						wait(80)
						stroboscopes(7086336, ptr, 2, 0, 0, 1)
						stroboscopes(7086336, ptr, 2, 0, 0, 0)
						wait(100)
						if not isCarSirenOn(car) or not isCharInAnyCar(PLAYER_PED) or strob_state == false then break end
						stroboscopes(7086336, ptr, 2, 0, 1, 1)
						stroboscopes(7086336, ptr, 2, 0, 1, 0)
						wait(80)
						stroboscopes(7086336, ptr, 2, 0, 0, 1)
						stroboscopes(7086336, ptr, 2, 0, 0, 0)
						wait(100)
						stroboscopes(7086336, ptr, 2, 0, 0, 1)
						stroboscopes(7086336, ptr, 2, 0, 1, 0)
						wait(80)
						stroboscopes(7086336, ptr, 2, 0, 1, 1)
						stroboscopes(7086336, ptr, 2, 0, 0, 0)
						if not isCarSirenOn(car) or not isCharInAnyCar(PLAYER_PED) or strob_state == false then break end
					end
					
					if not isCarSirenOn(car) or not isCharInAnyCar(PLAYER_PED) or strob_state == false then break end
				end
			end
		end
	end
end

function isCharInAnyCar(ped)
	local vehicles = {602, 545, 496, 517, 401, 410, 518, 600, 527, 436, 589, 580, 419, 439, 533, 549, 526, 491, 474, 445, 467, 604, 426, 507, 547, 585, 405, 587, 409, 466, 550, 492, 566, 546, 540, 551, 421, 516, 529, 485, 552, 431, 438, 437, 574, 420, 525, 408, 416, 596, 433, 597, 427, 599, 490, 528, 601, 407, 428, 544, 523, 470, 598, 499, 588, 609, 403, 498, 514, 524, 423, 532, 414, 578, 443, 486, 515, 406, 531, 573, 456, 455, 459, 543, 422, 583, 482, 478, 605, 554, 530, 418, 572, 582, 413, 440, 536, 575, 534, 567, 535, 576, 412, 402, 542, 603, 475, 568, 557, 424, 471, 504, 495, 457, 483, 508, 500, 444, 556, 429, 411, 541, 559, 415, 561, 480, 560, 562, 506, 565, 451, 434, 558, 494, 555, 502, 477, 503, 579, 400, 404, 489, 505, 479, 442, 458, 612, 613, 793, 794, 795, 796, 797, 798}
	for i, v in ipairs(vehicles) do
		if isCharInModel(ped, v) then return true end
	end
	return false
end
------------End---------------




function ImFileParse(text_path, img_sz, img_table, pattern)
	imgui.InputText(u8'Поиск', keyword)
	for line in io.lines(getWorkingDirectory()..text_path) do
		if string.find(line, keyword.v) then
			local img_id = string.match(line, pattern)
			if img_id ~= nil then
				imgui.Image(img_table[tonumber(img_id)], img_sz)
				imgui.SameLine()				
			end
			imgui.Text(string.gsub(line, '\\n', '\n'))
		end
	end
end

function fillImgTable(s, e, path)
	local t = {}
	for i = s, e do
		if doesFileExist(string.format('%s%s%d.png', getWorkingDirectory(), path, i)) then
			t[i] = imgui.CreateTextureFromFile(string.format('%s%s%d.png', getWorkingDirectory(), path, i))
		end
	end
	return t
end

function onScriptTerminate(s, q)
	if s.name == nameScript
	then
		SaveSetting()
	end
end

function onScriptLoad(s)
	if s.name == nameScript then
		LoadSetting()
	end
end

function GosVolna()
	local ImVec4 = imgui.ImVec4

				
	imgui.TextColored(ImVec4(1.0, 0.0, 0.0, 1.0), u8'Основные правила:')
	imgui.Text(u8"1. Интервал между занятием своей гос. волны после окончания")
	imgui.Text(u8"одного набора - 30 минут.")

	imgui.Text(u8"2. Создавать собеседование")
	imgui.SameLine()        
	imgui.TextColored(ImVec4(0.7, 0.0, 0.0, 1.0), u8'( /startvacancy )')
	imgui.SameLine()
	imgui.Text(u8'за 10 минут до начала,')
	imgui.Text(u8"максимум 60 минут.")

	imgui.Text(u8"3. Собеседование проводить")
	imgui.SameLine()
	imgui.TextColored(ImVec4(0.7, 0.0, 0.0, 1.0), u8'только в чётное время 10, 20, 30, 40, 50.')

	imgui.Text(u8"4. Собеседование в организацию")
	imgui.SameLine()
	imgui.TextColored(ImVec4(0.7, 0.0, 0.0, 1.0), u8'строго 30 минут.')

	imgui.Text(u8"5. Необходимо указывать где проходит собеседование/призыв, критерии.")
	imgui.Text(u8"6. Необходимо указывать сколько будет длиться собеседование/призыв.")

	imgui.Text(u8"7. Государственная волна доступна без ограничений на проведение наборов.")
	imgui.TextColored(ImVec4(0.7, 0.0, 0.0, 1.0), u8'Для отчёта строго с')
	imgui.SameLine()		
	imgui.TextColored(ImVec4(0.0, 0.0, 0.7, 1.0), u8'08:00 до 23:00.')
	imgui.SameLine()
	imgui.TextColored(ImVec4(0.7, 0.0, 0.0, 1.0), u8'Раньше/позже приняты в наборах не будут.')
	imgui.TextColored(ImVec4(0.3, 0.3, 0.3, 1.0), u8'(Исключение : после 23:00 можно ТОЛЬКО закончить собеседование)')

	imgui.Text(u8'8. Гос волна проводится')
	imgui.SameLine()
	imgui.TextColored(ImVec4(0.7, 0.0, 0.0, 1.0), u8'только')
	imgui.SameLine()
	imgui.Text(u8'в здании своей фракции/на месте проведения набора/призыва.')

	imgui.Text(u8'9. +-1 минута от начала собеседования по объявлению в /s собеседование')
	imgui.Text(u8'начато и системного окончания.')

	imgui.Text(u8'10. С момента окончания собеседования должно пройти 30 минут, чтобы')
	imgui.Text(u8'занимать новое собеседование (')
	imgui.SameLine()
	imgui.TextColored(ImVec4(0.7, 0.0, 0.0, 1.0), u8'в /startvacancy')
	imgui.SameLine()
	imgui.Text(u8').')

	imgui.Text(u8' ')
	imgui.Text(u8' ')

	imgui.TextColored(ImVec4(1.0, 0.0, 0.0, 1.0), u8'Правила занятия государственной волны:')

	imgui.Text(u8"1. Открыли")
	imgui.SameLine()
	imgui.TextColored(ImVec4(0.7, 0.0, 0.0, 1.0), u8'/vacancy')
	imgui.SameLine()
	imgui.Text(u8'посмотрели на какое время свободно собеседование.')
	imgui.Image(image_windows_gos_volna_1, imgui.ImVec2(372, 112));

	imgui.Text(u8'2. После чего открыли')
	imgui.SameLine()
	imgui.TextColored(ImVec4(0.7, 0.0, 0.0, 1.0), u8'/startvacancy')
	imgui.SameLine()
	imgui.Text(u8'Вписали критерии,')
	imgui.Text(u8'место проведения, и время.')
	imgui.Image(image_windows_gos_volna_2, imgui.ImVec2(372, 116))

	imgui.Text(u8'3. После чего нажали "Создать собеседование" и сделали скрин с /time')
	imgui.Text(u8'4. Прописываем команду /vacancy и /time + F8')
	imgui.Text(u8'5. Когда пришло время занятия гос.волны вы пишите /s Собеседование')
	imgui.Text(u8'начато /time + F8')
	imgui.Text(u8'6. По окончанию собеседования вы скрините системное окончание /time + F8')

	imgui.Text(u8' ')
	imgui.Text(u8' ')

	imgui.TextColored(ImVec4(1.0, 0.0, 0.0, 1.0), u8'Важно! За что вы можете быть наказаны.')
	imgui.Text(u8'1) Некорректное создание собеседования, ошибки в написании.')
	imgui.Text(u8'2) Не правильно указаны критерии, время начала/завершения/места.')
	imgui.Text(u8'3) АФК/Офф на активном собеседовании, отсутствие вас на активном')
	imgui.Text(u8'собеседовании.')

	imgui.Text(u8' ')
	imgui.Text(u8' ')

	imgui.TextColored(ImVec4(1.0, 0.0, 0.0, 1.0), u8'Правила подачи /gov новостей - для ЛИДЕРОВ.')
	imgui.Text(u8'1) Перед подачи /gov новостей проверьте заполнили ли вы все')
	imgui.Text(u8'правильно, нет ли у вас грамматических ошибок.')
	imgui.Text(u8'2) В подачи /gov новостей, доступно только 5 строк (с 1 по 5), шестая')
	imgui.Text(u8'не участвует в подачах.')
	imgui.Text(u8'3) Подавать /gov можно 1 фракции один раз в 30 минут, раньше будет')
	imgui.Text(u8'заявка отклонена.')
	imgui.Text(u8'4) В подачах /gov разрешено подавать ТОЛЬКО пиар заявлений на должности.')
	imgui.Text(u8'')
	imgui.Text(u8'Правильный пример подачи /gov новостей:')
	imgui.Image(image_windows_gos_volna_3, imgui.ImVec2(512, 256))

	imgui.Text(u8' ')
	imgui.Text(u8' ')

	imgui.TextColored(ImVec4(1.0, 0.0, 0.0, 1.0), u8'Правила эфиров СМИ')
	imgui.Text(u8'1. Проверить раскладку клавиатуры, чтобы не было ошибок (??????)')
	imgui.Text(u8'2. Обязательно использовать биндер (AutoHotKey])')
	imgui.Text(u8'3. Собеседование в организацию строго 30 минут.')
	imgui.Text(u8'4. Обязательно напомнить о собеседовании спустя 15 минут после')
	imgui.Text(u8'начала собеседования.')
	imgui.Text(u8'5. Окончание собеседование идет через эфир!')
	imgui.Text(u8'6. Необходимо указывать сколько будет длиться собеседование')
	imgui.Text(u8'7. Государственная волна доступна без ограничений на проведение наборов.')
	imgui.TextColored(ImVec4(0.7, 0.0, 0.0, 1.0), u8'Для отчёта строго с 08:00 до 23:00. Раньше/позже приняты в наборах не будут')
	imgui.TextColored(ImVec4(0.3, 0.3, 0.3, 1.0), u8'(Исключение : после 23:00 можно ТОЛЬКО закончить собеседование)')
	imgui.Text(u8'8. Опоздание подачи гос.волны не наказывается, если гос.волна')
	imgui.Text(u8'подана на +-1 минуту от занятого времени')
	imgui.Text(u8'9. Если у вас случилась какая то проблема в эфире то вы обязаны')
	imgui.Text(u8'написать Тех.Неполадки.')
	imgui.Text(u8'10. Эфир подается только в здании своей фракции/на месте')
	imgui.Text(u8'проведения набора (Парковка/Офис)')
	imgui.Text(u8'11. После окончания одного собеседование, следующее можно будет')
	imgui.Text(u8'занять минимум через 30 минут.')
	imgui.TextColored(ImVec4(0.7, 0.0, 0.0, 1.0), u8'Пример:')
	imgui.SameLine() 		
	imgui.TextColored(ImVec4(0.0, 0.4, 0.0, 1.0), u8'Закончился набор в 11:30, в 12:00 могу начать новое собеседование.')
	imgui.Text(u8' ')
	imgui.Separator()
	imgui.Text(u8' ')
	imgui.Text(u8'- За нарушение правил подачи эфиров лидером или его заместителем')
	imgui.Text(u8'выдается бан чата.')
	imgui.Text(u8'- За неоднократное нарушение правил подачи')
	imgui.Text(u8'эфиров - предупреждение/выговор лидеру.')
	imgui.Text(u8'- Подавать в эфире об начале собеседование нужно в ..:00, ..:10,')
	imgui.Text(u8'..:20, ..:30, ..:40, ..:50')
	imgui.Text(u8'- Напоминание об собеседовании собеседования -..:05, ..:15, ..:25,')
	imgui.Text(u8'..:35, ..:45, ..:55.')
	imgui.Text(u8'- За нарушение данных правил - лидер будет наказан')
	imgui.Text(u8'предупреждением/выговором.')

	imgui.Text(u8' ')
	imgui.TextColored(ImVec4(0.0, 0.7, 0.0, 1.0), u8'РАЗРЕШЕНО В ЭФИРЕ:')
	imgui.Text(u8'1. Объявления о начале, продолжении собеседования также')
	imgui.Text(u8'окончание собеседования')
	imgui.Text(u8'2. Проведение каких либо мероприятий, акций от организации: (Анаграммы, ')
	imgui.Text(u8'приветы и поздравления, страны и столицы, и т.д), объявления')
	imgui.Text(u8'о происходящем событии, работы гос. организации.')
	imgui.Text(u8'3. ВИП Рекламы (Бизнесов, Продажи, Покупки и т.д)')

	imgui.Text(u8' ')
	imgui.TextColored(ImVec4(1.0, 0.0, 0.0, 1.0), u8'ЗАПРЕЩЕНО В ЭФИРЕ:')
	imgui.Text(u8'1. Оскорбления')
	imgui.Text(u8'2. МГ, Транслит, капс')
	imgui.Text(u8'3. Бред в Эфире.')
	imgui.Text(u8'4. Запрещён сбор денег в эфире (поиск спонсоров).')
	imgui.Text(u8'5. АФК или неявка во время набора')
end

function Uearhuya()
	local ImVec4 = imgui.ImVec4
	imgui.TextColored(ImVec4(1, 1, 0, 1), u8"Администрация Президента.");
	imgui.TextColored(ImVec4(229, 110, 19, 1), u8"Президент");
	imgui.SameLine();
	imgui.TextColored(ImVec4(0.3, 0.3, 0.3, 1.0), u8"->");
	imgui.SameLine();
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"руководит всеми гос.структурами и областью в целом");
	imgui.TextColored(ImVec4(229, 110, 19, 1), u8"Вице-Президент");
	imgui.SameLine();
	imgui.TextColored(ImVec4(0.3, 0.3, 0.3, 1.0), u8"->");
	imgui.SameLine();
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"руководит всеми гос.структурами,не включая Директора ФСБ и его Заместителей.");
	imgui.TextColored(ImVec4(229, 110, 19, 1), u8"Мин.Обороны");
	imgui.SameLine();
	imgui.TextColored(ImVec4(0.3, 0.3, 0.3, 1.0), u8"->");
	imgui.SameLine();
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"руководит Армиями.");
	imgui.TextColored(ImVec4(229, 110, 19, 1), u8"Мин.МВД");
	imgui.SameLine();
	imgui.TextColored(ImVec4(0.3, 0.3, 0.3, 1.0), u8"->");
	imgui.SameLine();
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"руководит ПА, ПЮ и ГИБДД.");
	imgui.TextColored(ImVec4(229, 110, 19, 1), u8"Мин. Здравоохранения");
	imgui.SameLine();
	imgui.TextColored(ImVec4(0.3, 0.3, 0.3, 1.0), u8"->");
	imgui.SameLine();
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"руководит ЦГБ-А и ЦГБ-Ю.");
	imgui.TextColored(ImVec4(229, 110, 19, 1), u8"Мин.Связи");
	imgui.SameLine();
	imgui.TextColored(ImVec4(0.3, 0.3, 0.3, 1.0), u8"->");
	imgui.SameLine();
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"руководит СМИ.");
	imgui.TextColored(ImVec4(229, 110, 19, 1), u8"Министр финансов");
	imgui.SameLine();
	imgui.TextColored(ImVec4(0.3, 0.3, 0.3, 1.0), u8"->");
	imgui.SameLine();
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"руководит АШ.");
	imgui.TextColored(ImVec4(1, 1, 0, 1), u8"Администрация Батырево.");
	imgui.TextColored(ImVec4(229, 110, 19, 1), u8"Мэр");
	imgui.SameLine();
	imgui.TextColored(ImVec4(0.3, 0.3, 0.3, 1.0), u8"->");
	imgui.SameLine();
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"руководит гос.структурами Батырево, подчиняется Президенту...");
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"...Вице-Президенту и Руководству ФСБ.");
	imgui.TextColored(ImVec4(229, 110, 19, 1), u8"Вице-Мэр");
	imgui.SameLine();
	imgui.TextColored(ImVec4(0.3, 0.3, 0.3, 1.0), u8"->");
	imgui.SameLine();
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"руководит гос.структурами Батырево, подчиняется Президенту...");
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"...Вице-Президенту ,Мэру ,Зам.Директору и Директору ФСБ.");
	imgui.TextColored(ImVec4(229, 110, 19, 1), u8"Инспектор");
	imgui.SameLine();
	imgui.TextColored(ImVec4(0.3, 0.3, 0.3, 1.0), u8"->");
	imgui.SameLine();
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"руководит гос.структурами Батырево, подчиняется Вице-Мэру ...");
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"...и выше поставленным ему лицам.");
	imgui.TextColored(ImVec4(1, 1, 0, 1), u8"Федеральная Служба Безопасности.");
	imgui.TextColored(ImVec4(229, 110, 19, 1), u8"Директор");
	imgui.SameLine();
	imgui.TextColored(ImVec4(0.3, 0.3, 0.3, 1.0), u8"->");
	imgui.SameLine();
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"руководит всем в области, подчиняются исключительно Президенту.");
	imgui.TextColored(ImVec4(229, 110, 19, 1), u8"Зам.Директора");
	imgui.SameLine();
	imgui.TextColored(ImVec4(0.3, 0.3, 0.3, 1.0), u8"->");
	imgui.SameLine();
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"всем в области, не включая Президента");
	imgui.TextColored(ImVec4(229, 110, 19, 1), u8"Инспектор");
	imgui.SameLine();
	imgui.TextColored(ImVec4(0.3, 0.3, 0.3, 1.0), u8"->");
	imgui.SameLine();
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"руководит ТОЛЬКО силовыми гос.структурами, не включая...");
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"...Полковников и выше. Подчиняется толькоСтаршему Руководству ФСБ и Президенту.");
	imgui.TextColored(ImVec4(1, 1, 0, 1), u8"Полиция и ГИБДД.");
	imgui.TextColored(ImVec4(229, 110, 19, 1), u8"Генерал");
	imgui.SameLine();
	imgui.TextColored(ImVec4(0.3, 0.3, 0.3, 1.0), u8"->");
	imgui.SameLine();
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"руководит младшими по званию силовиками. Подчиняется: Директору ФСБ...");
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"...Зам Директора ФСБ, Вице-Президенту, Президенту и Мин.МВД");
	imgui.TextColored(ImVec4(0.3, 0.3, 0.3, 1.0), u8"Генералом ГИБДД руководит ещё - Мэр и Вице-Мэр.");
	imgui.TextColored(ImVec4(229, 110, 19, 1), u8"Полковник");
	imgui.SameLine();
	imgui.TextColored(ImVec4(0.3, 0.3, 0.3, 1.0), u8"->");
	imgui.SameLine();
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"руководит младшими по званию силовиками ВНУТРИ своей фракции...");
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"...Подчиняется: Директору ФСБ, Зам.Директора, Вице-Президенту, Президенту и Мин. МВД.");
	imgui.TextColored(ImVec4(0.3, 0.3, 0.3, 1.0), u8"Полковником ГИБДД руководит ещё - Мэр ,Вице Мэр и Инспектор АБ.");
	imgui.TextColored(ImVec4(229, 110, 19, 1), u8"Подполковник и Майор");
	imgui.SameLine();
	imgui.TextColored(ImVec4(0.3, 0.3, 0.3, 1.0), u8"->");
	imgui.SameLine();
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"руководит младшими по званию силовиками ВНУТРИ своей фракции...");
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"...Подчиняется: Полковнику и выше поставленным лицам.");
	imgui.TextColored(ImVec4(1, 1, 0, 1), u8"АРМИЯ 'АМВ' и 'ВМФ'");
	imgui.TextColored(ImVec4(229, 110, 19, 1), u8"Генерал");
	imgui.SameLine();
	imgui.TextColored(ImVec4(0.3, 0.3, 0.3, 1.0), u8"->");
	imgui.SameLine();
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"руководит младшими по званию ВНУТРИ своей фракции...");
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"...Подчиняется: Директору ФСБ, Зам Директора ФСБ, Вице-Президенту...");
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"...Президенту и Мин.Обороны. (Мэру и Вице Мэру - Для ВВС)");
	imgui.TextColored(ImVec4(229, 110, 19, 1), u8"Полковник");
	imgui.SameLine();
	imgui.TextColored(ImVec4(0.3, 0.3, 0.3, 1.0), u8"->");
	imgui.SameLine();
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"руководит младшими по званию ВНУТРИ своей фракции.");
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"Подчиняется: Генералу ,Директору ФСБ, Зам.Директора, Вице-Президенту...");
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"...Президенту и Мин.Обороны . (Мэру ,Вице Мэру и Инспектору АБ - Для ГИБДД)");
	imgui.TextColored(ImVec4(229, 110, 19, 1), u8"Подполковник и Майор");
	imgui.SameLine();
	imgui.TextColored(ImVec4(0.3, 0.3, 0.3, 1.0), u8"->");
	imgui.SameLine();
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"руководит младшими по званию ВНУТРИ своей фракции...");
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"...Подчиняется: Полковнику и выше поставленным лицам.");
	imgui.TextColored(ImVec4(1, 1, 0, 1), u8"СМИ");
	imgui.TextColored(ImVec4(229, 110, 19, 1), u8"Директор ");
	imgui.SameLine();
	imgui.TextColored(ImVec4(0.3, 0.3, 0.3, 1.0), u8"->");
	imgui.SameLine();
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"руководит младшими по должности ВНУТРИ своей фракции. Подчиняется:...");
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"...Директору ФСБ, Зам.Дир. ФСБ, Президенту, Вице-Президенту, и Мин.Связи.");
	imgui.TextColored(ImVec4(229, 110, 19, 1), u8"Зам.Директора");
	imgui.SameLine();
	imgui.TextColored(ImVec4(0.3, 0.3, 0.3, 1.0), u8"->");
	imgui.SameLine();
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"руководит младшими по должности ВНУТРИ своей фракции. Подчиняется: Директору...");
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"...Директору ФСБ, Зам.Дир. ФСБ, Президенту, Вице-Президенту, и Мин.Связи.");
	imgui.TextColored(ImVec4(1, 1, 0, 1), u8"Больницы");
	imgui.TextColored(ImVec4(229, 110, 19, 1), u8"Глав.Врач");
	imgui.SameLine();
	imgui.TextColored(ImVec4(0.3, 0.3, 0.3, 1.0), u8"->");
	imgui.SameLine();
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"руководит младшими по должности ВНУТРИ своей фракции. Подчиняется: Директору ФСБ...");
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"...Зам.Дир. ФСБ, Президенту, Вице-Президенту и Министр. Здравохр.");
	imgui.TextColored(ImVec4(229, 110, 19, 1), u8"Зам.Глав.Врача");
	imgui.SameLine();
	imgui.TextColored(ImVec4(0.3, 0.3, 0.3, 1.0), u8"->");
	imgui.SameLine();
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"руководит младшими по должности ВНУТРИ своей фракции. Подчиняется: Директору ФСБ...");
	imgui.TextColored(ImVec4(128, 28, 28, 1), u8"...Глав.Врачу, Президенту, Вице-Президенту и Министр. Здравохр.");
	imgui.TextColored(ImVec4(0.3, 0.3, 0.3, 1.0), u8" ");
	imgui.TextColored(ImVec4(0.3, 0.3, 0.3, 1.0), u8"Примечание: ФСБ может проверить любую гос фракцию в целом и им не должно быть отказано.");
	imgui.TextColored(ImVec4(0.3, 0.3, 0.3, 1.0), u8"В случае отказа Лидер организации несет полную ответственность.");
	imgui.TextColored(ImVec4(0.3, 0.3, 0.3, 1.0), u8"Дополнение: Если в организации менее 3 - х сотрудников проверку");
	imgui.TextColored(ImVec4(0.3, 0.3, 0.3, 1.0), u8"фракции проводить запрещено(Не включая Лидера и Заместителей).");
	imgui.Text("")
	imgui.Separator()
	imgui.Text("")
	imgui.Image(image_ierarhiya, imgui.ImVec2(672,672));
end

function Loka()
	if imgui.TreeNode(u8'Гос. огранизации') then
		imgui.Text(u8"Администрация призидента")
		imgui.Image(image_adm_priz, imgui.ImVec2(512,288));
		imgui.Text(u8" ")

		imgui.Text(u8"Администрация Батырево")
		imgui.Image(image_adm_bat, imgui.ImVec2(512,288));
		imgui.Text(u8" ")

		imgui.Text(u8"ФСБ")
		imgui.Image(image_fsb, imgui.ImVec2(512,288));
		imgui.Text(u8" ")

		imgui.Text(u8"Полиция Южного")
		imgui.Image(image_pol_uzk, imgui.ImVec2(512,288));
		imgui.Text(u8" ")

		imgui.Text(u8"Полиция Арзамаса")
		imgui.Image(image_pol_arz, imgui.ImVec2(512,288));
		imgui.Text(u8" ")

		imgui.Text(u8"ГИБДД")
		imgui.Image(image_gubdd, imgui.ImVec2(512,288));
		imgui.Text(u8" ")

		imgui.Text(u8"СМИ")
		imgui.Image(image_smi, imgui.ImVec2(512,288));
		imgui.Text(u8" ")

		imgui.Text(u8"ЦГБ Арзамаса")
		imgui.Image(image_bolka_arz, imgui.ImVec2(512,288));
		imgui.Text(u8" ")

		imgui.Text(u8"ЦГБ Южного")
		imgui.Image(image_bolka_uzk, imgui.ImVec2(512,288));
		imgui.Text(u8" ")

		imgui.Text(u8"Автошкола")
		imgui.Image(image_avtochkola, imgui.ImVec2(512,288));
		imgui.Text(u8" ")

		imgui.Text(u8"ВМФ")
		imgui.Image(image_vmf, imgui.ImVec2(512,288));
		imgui.Text(u8" ")

		imgui.Text(u8'Армия"МВ"')
		imgui.Image(image_amv, imgui.ImVec2(512,288));
		imgui.Text(u8" ")
		imgui.TreePop()
	end
	if imgui.TreeNode(u8'ОПГ/Мафия') then
		imgui.Text(u8"Итальянская мафия")
		imgui.Image(image_ut_mafia, imgui.ImVec2(512,288));
		imgui.Text(u8" ")
		imgui.Text(u8"Русская мафия")
		imgui.Image(image_rus_mafia, imgui.ImVec2(512,288));
		imgui.Text(u8" ")
		imgui.Text(u8"Якудза")
		imgui.Image(image_yakydza, imgui.ImVec2(512,288));
		imgui.Text(u8" ")

		imgui.Text(u8"Тяп-Ляп")
		imgui.Image(image_tyap_lyap, imgui.ImVec2(512,288));
		imgui.Text(u8" ")
		imgui.Text(u8"Суконка")
		imgui.Image(image_sykonka, imgui.ImVec2(512,288));
		imgui.Text(u8" ")
		imgui.Text(u8"Тукаевские")
		imgui.Image(image_tykaevckie, imgui.ImVec2(512,288));
		imgui.Text(u8" ")
		imgui.Text(u8"Хади-Такташ")
		imgui.Image(image_hadi_taktash, imgui.ImVec2(512,288));
		imgui.Text(u8" ")
		imgui.TreePop()
	end
end
