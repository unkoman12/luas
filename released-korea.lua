function xB_A(s)
    local v='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    s = string.gsub(s, '[^'..v..'=]', '')
    return (s:gsub('.', function(w)
        if (w == '=') then return '' end
        local a,b='',(v:find(w)-1)
        for i=6,1,-1 do a=a..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return a
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(z)
        if (#z ~= 8) then return '' end
        local n=0
        for j=1,8 do n=n+(z:sub(j,j)=='1' and 2^(8-j) or 0) end
        return string.char(n)
    end))
end
local encoded_password = "ZDQ2NjA2ZTgtODk3OS00MzBhLTg1Y2MtMzU0Y2EwNTcyMDQ0" --korea
local correct_password = xB_A(encoded_password)
local is_authenticated = false
function prompt_password()
    if is_authenticated then
        return true
    end

    local user_input = gg.prompt({"Enter Password:"}, nil, {gg.TYPE_STRING})
    if user_input == nil then
        gg.alert("Password entry was canceled.")
        os.exit()
    elseif user_input[1] == correct_password then
        gg.alert("Password is correct! Access granted.")
        is_authenticated = true
        return true
    else
        gg.alert("Incorrect password!")
        os.exit()
    end
end

function Main()
    Menu = gg.choice({ 
        "重力系メニュー",
        "座標系メニュー",
        "人物系メニュー",
        "武器系メニュー",
        "その他メニュー",
        "宝箱系メニュー",
        "全体系メニュー",
        "よころわメニュー",
        "説明",
        "終了",
    }, nil, '製作者:@MumbleDebug')
    if Menu == 1 then grav() end
    if Menu == 2 then Current() end
    if Menu == 3 then movement() end
    if Menu == 4 then weapons() end
    if Menu == 5 then Misc1() end
    if Menu == 6 then ChestMenu() end
    if Menu == 7 then gameZen() end
    if Menu == 8 then yokorowa() end
    if Menu == 9 then q() end
    if Menu == 10 then os.exit() end
    YUNI = -1
end
function q()
    gg.alert("武器反映は落ちやすいです。時々無重力入らないかも知れません。あと普通にMAPがバグります。あと武器改造は毎試合オンオフしないと使えません。")
    gg.alert("💀scarletとhahaha殺すぞ")
end

function ChestMenu()      
    siubo = gg.multiChoice({
        "全宝箱スイッチ",
    }, nil, 'made by MumbleDebug')
    
    if siubo == nil then return end  
    
    if siubo[1] then ChestMenu0() end
    YUNI = -1
end

function ChestMenu0()
    gg.clearResults()
    gg.searchNumber("h9F89BF5E 9F9F891E", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    gg.searchNumber("-97", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1000)
    local dizh1 = {}
    local dizh2 = 1
    for i = 1, #r do
      dizh1[dizh2] = {}
      dizh1[dizh2].address = r[i].address + 0x78
      dizh1[dizh2].flags = gg.TYPE_DWORD
      dizh1[dizh2].value = 1
      dizh2 = dizh2 + 4
      i = i + 1
    end 
    gg.setValues(dizh1)
end    
 

function grav()
    siubo = gg.multiChoice({
        "無重力 ON",
        "無重力 OFF",
        "アニメーション無効",
    }, nil, 'PlayinEscapePro')
    
    if siubo == nil then return end  
    
    if siubo[1] then iszerogravity() end
    if siubo[2] then unzerogravity() end
    if siubo[3] then opt() end
    YUNI = -1
end


function opt()
    gg.clearResults()
    gg.searchNumber("h0000803FABAAAA3E8FC2F53C", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    revert = gg.getResults(100, nil, nil, nil, nil, nil, nil, nil, nil)
    gg.editAll("h0000803FABAAAA3E00000000", gg.TYPE_BYTE)
    gg.processResume()
    gg.toast("軽量化成功")
    gg.clearResults()
    end

function iszerogravity()
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("C1E00000h", gg.TYPE_QWORD, false, gg.SIGN_EQUAL, 0, -1)
    local revert = gg.getResults(1000)
    
    if #revert > 0 then
        gg.editAll("BA921000h",gg.TYPE_QWORD)
        gg.processResume()
        gg.toast("無重力 ON")
    else
        gg.toast("検索結果が見つかりませんでした")
    end
    
    gg.clearResults()
end

function unzerogravity()
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("BA921000h", gg.TYPE_QWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
    local revert = gg.getResults(1000) 
    if #revert > 0 then
        gg.editAll("C1E00000h", gg.TYPE_QWORD)
        gg.processResume()
        gg.toast("無重力 OFF")
    else
        gg.toast("検索結果が見つかりませんでした")
    end
    
    gg.clearResults()
end
function dizh1()
        gg.setRanges(gg.REGION_C_DATA)
        gg.searchNumber("h9A99993E", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
        
        local revert = gg.getResults(100)
        
        if #revert > 0 then
            gg.editAll("h003C1C46003C1C46", gg.TYPE_BYTE)
            gg.processResume()
            gg.toast("無限ジャンプON")
        else
            gg.toast("検索結果が見つかりませんでした")
        end
        
        gg.clearResults()
    end

    function Current()
        siubo = gg.multiChoice({
            "現在の座標を表示",
            "白チームの前にTP",
            "赤チームの前にTP",
            "カスタムテレポート",
        }, nil, 'PlayinEscapePro')
        
        if siubo == nil then return end  
        
        if siubo[1] then NowON() end
        if siubo[2] then whitebaseTP() end
        if siubo[3] then redbaseTP() end
        if siubo[4] then customTP() end
        YUNI = -1
    end


function NowON()
    gg.alert("これはデバッガー用です。開発者以外は使用できません")
end

function whitebaseTP()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.clearResults()
    gg.searchNumber("17170436", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
    local results = gg.getResults(gg.getResultCount())

    if #results > 0 then
        local a = {}
        local n = 1
        for i = 1, #results do
            a[n] = { address = results[i].address - 12, flags = gg.TYPE_FLOAT, value = 1127.361992 } 
            n = n + 1
            a[n] = { address = results[i].address - 8, flags = gg.TYPE_FLOAT, value = 1.21 } 
            n = n + 1
            a[n] = { address = results[i].address - 4, flags = gg.TYPE_FLOAT, value = -119.180000 } 
            n = n + 1
        end 
        gg.setValues(a)
        gg.toast("座標移動成功")
    else
        gg.toast("検索結果が見つかりませんでした")
    end
end
function redbaseTP()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.clearResults()
    gg.searchNumber("17170436", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
    local results = gg.getResults(gg.getResultCount())

    if #results > 0 then
        local a = {}
        local n = 1
        for i = 1, #results do
            a[n] = { address = results[i].address - 12, flags = gg.TYPE_FLOAT, value = -1127.361992 } 
            n = n + 1
            a[n] = { address = results[i].address - 8, flags = gg.TYPE_FLOAT, value = 1.21 } 
            n = n + 1
            a[n] = { address = results[i].address - 4, flags = gg.TYPE_FLOAT, value = -119.180000 } 
            n = n + 1
        end 
        gg.setValues(a)
        gg.toast("座標移動成功")
    else
        gg.toast("検索結果が見つかりませんでした")
    end
end


function customTP()
    gg.alert("これはデバッガー用です。開発者以外は使用できません")
end

function movement()
    siubo = gg.multiChoice({
        "ハイジャンプ",
        "ハイスピード",
        "無限ジャンプ",
        "水ジャンプ",
        "バトロワ無敵",
        "ヨコロワ無敵",
    }, nil, 'PlayinEscapePro')
    
    if siubo == nil then return end  
    
    if siubo[1] then HighJump() end
    if siubo[2] then Highspeed() end
    if siubo[3] then airjump() end
    if siubo[4] then waterjump() end
    if siubo[5] then muteki() end
    if siubo[6] then yokorowamuteki() end
    YUNI = -1
end

function yokorowamuteki()
    gg.alert("これはデバッガー用です。開発者以外は使用できません")
end


function waterjump()
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("1,121,193,960", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1000)
    local a = {}
    local n = 1
    
    for i = 1, #r do
      a[n] = {}
      a[n].address = r[i].address - 0xA8
      a[n].flags = gg.TYPE_DWORD
      a[n].value = 1
      a[n].freeze = true
      n = n + 1
    end 
    
    gg.setValues(a)
    gg.addListItems(a) 
  end


function HighJump()
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("2047615188", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
    local revert = gg.getResults(100)
    gg.editAll("2067728458", gg.TYPE_DWORD)
    gg.processResume()
    gg.toast("ハイジャンプON")
    gg.clearResults()
end

function Highspeed()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.clearResults()
    gg.searchNumber("6.874417363427344e+28", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
    local revert = gg.getResults(100)
    if revert then
        gg.editAll("8.0000002e26", gg.TYPE_FLOAT)
        gg.toast("ハイスピードON")
    else
        gg.toast("検索結果が見つかりませんでした")
    end
    gg.clearResults()
end

function muteki()
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("h6400000001010000", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    gg.refineNumber("100", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1000)

    if r then
        local a = {}
        local n = 1
        for i = 1, #r do
            a[n] = { address = r[i].address - 0x8, flags = gg.TYPE_DWORD, value = 99999 }
            n = n + 1
        end 
        gg.toast("無敵ON")
        gg.setValues(a)
    else
        gg.toast("検索結果が見つかりませんでした")
    end
end

function airjump()
    gg.clearResults()
    gg.setRanges(gg.REGION_C_DATA)
    gg.searchNumber("h9A99993E", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    
    local revert = gg.getResults(100)
    
    if #revert > 0 then
        gg.editAll("h003C1C46003C1C46", gg.TYPE_BYTE)
        gg.processResume()
        gg.toast("無限ジャンプON")
    else
        gg.toast("検索結果が見つかりませんでした")
    end
    
    gg.clearResults()
end

function weapons()
        siubo = gg.multiChoice({
            "武器連射＋反映",
            "武器改造 ON",
            "武器改造 OFF",
            "武器連射 通常モード",
            "SPAIサポートモード",
            "パンチのみ連射",
        }, nil, 'PlayinEscapePro')
        
        if siubo == nil then return end  
        
        if siubo[1] then hanei() end
        if siubo[2] then modweaponON() end
        if siubo[3] then modweaponOFF() end
        if siubo[4] then rapitfireNomal() end
        if siubo[5] then rapitfirespai() end
        if siubo[6] then hikakin() end
        YUNI = -1
    end

--tstwettdwtdwtdtwdwt
    function OLDwON()
        local modifications = {
            {search = "5,498,138,235,623,002,013", edit = "4,341,835,367,419,304,782", toast = "グレネード改造"},
            {search = "6,558,252,613,970,925,570", edit = "6,339,221,200,358,174,732", toast = "ラケット改造"},
            {search = "h1CBFC976 18BFC976", edit = "h740F455E E21C455E", toast = "水鉄砲改造"},
            {search = "hD3811F66 DF811F66", edit = "h12540161 794D0161", toast = "リモボ改造"},
            {search = "hA9F77540 A7F77540", edit = "h64AB317D 12BC317D", toast = "火炎銃改造"},
            {search = "h70587542 7D587542", edit = "h64AB317D F0B8317D", toast = "シャボン銃改造"},
            {search = "h89B38241 83B38241", edit = "hA7E00A51 E6F50A51", toast = "インパルス改造"},
            {search = "h0EF0EF66 0CF0EF66", edit = "h0994097F EC93097F", toast = "人狼改造"},
            {search = "h21BA7D79 29BA7D79", edit = "h9416F973 8616F973", toast = "テレポート改造"},
            {search = "h1115BC71 1715BC71", edit = "h2DCD5D63 75D85D63", toast = "足止め改造"}
        }
    
        for _, mod in ipairs(modifications) do
            gg.clearResults()
            gg.setRanges(gg.REGION_ANONYMOUS)
            gg.searchNumber(mod.search, gg.TYPE_QWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
            local revert = gg.getResults(100)
            gg.editAll(mod.edit, gg.TYPE_QWORD)
            gg.processResume()
            gg.toast(mod.toast)
        end
    end

    

    function rapitfirespai()
        local patterns = {
            "h7E 93 93 6B",
            "hAE FF 78 3D",
            "h25 90 0D 6A",
            "hA4 CF FE 78",
            "h2C 3F 0B 63",
            "h69 F8 04 58",
            "1,515,282,994",
            "1,165,510,785",
            "h45 78 48 81"
        }
    
        for _, pattern in ipairs(patterns) do
            gg.clearResults()
            gg.setRanges(gg.REGION_ANONYMOUS)
            gg.searchNumber(pattern, gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
            local r = gg.getResults(1000)
            local a = {}
            local n = 1
    
            for i = 1, #r do
                a[n] = { address = r[i].address - 20, flags = gg.TYPE_DWORD, value = 0 }
                n = n + 1
                a[n] = { address = r[i].address - 16, flags = gg.TYPE_DWORD, value = 0 }
                n = n + 1
                a[n] = { address = r[i].address + 32, flags = gg.TYPE_DWORD, value = 0 }
                n = n + 1
                a[n] = { address = r[i].address + 36, flags = gg.TYPE_DWORD, value = 0 }
                n = n + 1
    
                if pattern == "1,165,510,785" then
                    a[n] = { address = r[i].address - 10, flags = gg.TYPE_DWORD, value = 0 }
                    n = n + 1
                    a[n] = { address = r[i].address + 10, flags = gg.TYPE_DWORD, value = 0 }
                    n = n + 1
                    a[n] = { address = r[i].address - 24, flags = gg.TYPE_DWORD, value = 0 }
                    n = n + 1
                end
            end
    
            gg.setValues(a)
        end
    end



    function rapitfireNomal()
        local patterns = {
            "h10 AA 6E 67",
            "h65 88 73 6E",
            "h25 90 0D 6A",
            "h62 B9 C3 4A",
            "hDD 65 9A 4B",
            "h9F 1E 21 66",
            "hD8 F5 44 60",
            "hA4 CF FE 78",
            "h69 F8 04 58",
            "h3E AC B6 54",
            "h2C 3F 0B 63",
            "h50 6B E7 40"
        }
    
        for _, pattern in ipairs(patterns) do
            gg.clearResults()
            gg.setRanges(gg.REGION_ANONYMOUS)
            gg.searchNumber(pattern, gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
            local results = gg.getResults(1000)
            local addresses = {}
    
            for _, result in ipairs(results) do
                for offset = -20, 36, 16 do  
                    table.insert(addresses, { address = result.address + offset, flags = gg.TYPE_DWORD, value = 0 })
                end
            end
    
            gg.setValues(addresses)
        end
    end
    
    
  function hanei()
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    
    local searchValues = {
        { "1735305744", { -0x44, -0x88, -0xA0, -0x14, -0x10, 0x10, 0x20, 0x24 }, "パンチ" },
        { "1,031,339,950", { -0x44, -0x88, -0xA0, -0x14, -0x10, 0x10, 0x20, 0x24 }, "SAI入手器" },
        { "1476720745", { -0x44, -0x84, -0xA0, -0x14, -0x10, 0x10, 0x20, 0x24 }, "AIワープ" },
        { "1165510785", { -0x44, -0x84, -0xA0, -0x14, -0x10, 0x10, 0x20, 0x24 }, "瓶" },
        { "1088908112", { -0x44, -0x88, -0xA0, -0x14, -0x10, 0x10, 0x20, 0x24 }, "大砲" },
        { "1853065317", { -0x44, -0x84, -0xA0, -0x14, -0x10, 0x10, 0x20, 0x24 }, "グレネード系" },
        { "1254340962", { -0x44, -0x14, -0x10, 0x10, 0x20, 0x24 }, "人狼棒、看守武器" },
        { "1515282994", { -0x44, -0x80, -0x84, -0x14, -0x10, 0x10, 0x20, 0x24 }, "流星群" },
        { "1268409821", { -0x44, -0x80, -0x84, -0x14, -0x10, 0x10, 0x20, 0x24 }, "足止め" },
        { "1779273765", { -0x44, -0x80, -0x84, -0x14, -0x10, 0x10, 0x20, 0x24 }, "フジフジ拘束" },
        { "1713446559", { -0x44, -0x80, -0x84, -0x14, -0x10, 0x10, 0x20, 0x24 }, "水鉄砲系" },
        { "2029965220", { -0x44, -0x80, -0x84, -0x14, -0x10, 0x10, 0x20, 0x24 }, "インパルス" },
        { "1615132120", { -0x44, -0x80, -0x84, -0x14, -0x10, 0x10, 0x20, 0x24 }, "水風船" },
        { "1661681452", { -0x44, -0x80, -0x84, -0x14, -0x10, 0x10, 0x20, 0x24 }, "れもぼ" },
    }
--1661681452
    for _, searchInfo in ipairs(searchValues) do
        local numberToSearch = searchInfo[1]
        local offsets = searchInfo[2]
        local itemName = searchInfo[3]

        gg.searchNumber(numberToSearch, gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
        local results = gg.getResults(1000)
        local setValues = {}

        for _, r in ipairs(results) do
            for _, offset in ipairs(offsets) do
                local entry = {}
                entry.address = r.address + offset 
                entry.flags = gg.TYPE_DWORD
                entry.value = 0
                table.insert(setValues, entry)
            end
        end

        if #setValues > 0 then
            gg.setValues(setValues)
            gg.toast(itemName .. " を変更または連射可能にしました。")
        end

        gg.clearResults()
    end
end



function modweaponON()
    local searches = {
        {search = "4788831073787533424", edit = "7,014,110,306,751,690,576"},--周囲ダメージ
        {search = "8754357937972820513", edit = "7594854902521026534"},--TP
        {search = "4720532735758873481", edit = "5839750236390219943"},--バリア
        {search = "4644890888415606697", edit = "7072042234402891557"},--バリア
        {search = "7358743112637710803", edit = "7594854902521026534"},--周囲ダメージ
    }

    for i, v in ipairs(searches) do
        gg.clearResults()
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber(v.search, gg.TYPE_QWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
        local revert = gg.getResults(100)
        gg.editAll(v.edit, gg.TYPE_QWORD)
        gg.processResume()
    end

    gg.clearResults()
end

function modweaponOFF()
    local searches = {
        {search = "7,037,678,785,175,149,466", edit = 4788831073787533424},
        {search = "8,714,128,229,137,304,946", edit = 8754357937972820513},
        {search = "4,348,150,287,900,851,118", edit = 4720532735758873481},
        {search = "4,779,651,813,845,810,188", edit = 4644890888415606697},
        {search = "6830252227170004540", edit = 7358743112637710803},
    }

    for i, v in ipairs(searches) do
        gg.clearResults()
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber(v.search, gg.TYPE_QWORD, false, gg.SIGN_EQUAL, 0, -1)
        
        local r = gg.getResults(1000)
        local a = {}
        for j = 1, #r do
            a[j] = {}
            a[j].address = r[j].address + 0x10
            a[j].flags = gg.TYPE_QWORD
            a[j].value = v.edit
        end
        gg.setValues(a)
    end

    gg.clearResults()
end

function hikakin()
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("h10 AA 6E 67", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1000)
    local a = {}
    local n = 1
    for i = 1, #r do
      a[n] = {}
      a[n].address = r[i].address - 20
      a[n].flags = gg.TYPE_DWORD
      a[n].value = 0
      a[n + 1] = {}
      a[n + 1].address = r[i].address - 16
      a[n + 1].flags = gg.TYPE_DWORD
      a[n + 1].value = 0
      a[n + 2] = {}
      a[n + 2].address = r[i].address + 32
      a[n + 2].flags = gg.TYPE_DWORD
      a[n + 2].value = 0
      a[n + 3] = {}
      a[n + 3].address = r[i].address + 36
      a[n + 3].flags = gg.TYPE_DWORD
      a[n + 3].value = 0
      n = n + 4
      i = i + 1
    end 
    gg.setValues(a)
end 

function Misc1()
    siubo = gg.multiChoice({
        "トラップ無効",
        "TP クールタイム無効",
        "近接拘束 クールタイム無効",
        "クールタイム無効武器 反映",
        "(hvh) パンチ => 看守棒",
        "(hvh) 拘束槍 => にゃっくる",
        "(hvh) パンチ => アイス",
        "くそ緑拘束無効",
        "TP無効",
        "トラップ無効",
        "りモボ連射",
        "ぱんちのやつ",
        "バリア連射軽量化",
        "周囲ダメージ軽量化",
    }, nil, 'PlayinEscapePro')
    
    if siubo == nil then return end  
    
    if siubo[1] then trap() end
    if siubo[2] then tpcooltime() end
    if siubo[3] then hikakin() end
    if siubo[4] then modifyValues() end
    if siubo[5] then aa5() end
    if siubo[6] then aa6() end
    if siubo[7] then aa7() end
    if siubo[8] then aa9() end
    if siubo[9] then aa10() end
    if siubo[10] then aa11() end
    if siubo[11] then aa12() end
    if siubo[12] then aa13() end
    if siubo[13] then aa14() end
    if siubo[14] then rangesdamage() end
    YUNI = -1
end

function hikakin()
    local function setValuesByNumber(searchNumber)
        local a = {}
        gg.clearResults()
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber(searchNumber, gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
        local results = gg.getResults(1000)
        local n = 1

        for i = 1, #results do
            
            a[n] = {}
            a[n].address = results[i].address + 0x8
            a[n].flags = gg.TYPE_DWORD
            a[n].value = 0
            n = n + 1
            
            
            a[n] = {}
            a[n].address = results[i].address + 0xC
            a[n].flags = gg.TYPE_DWORD
            a[n].value = 0
            n = n + 1
        end
        
        gg.setValues(a)
    end
    local searchNumbers = {
        "1302831744",
        "1712520725",
        "1939385807"
    }
    for _, num in ipairs(searchNumbers) do
        setValuesByNumber(num)
    end
end


function tpcooltime()
    local a = {}
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("1784006213", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1000)

    if r then
        local n = 1
        for i = 1, #r do
            a[n] = { address = r[i].address + 0x8, flags = gg.TYPE_DWORD, value = 0 }
            n = n + 1
            a[n] = { address = r[i].address + 0xC, flags = gg.TYPE_DWORD, value = 0 }
            n = n + 1
        end
        gg.setValues(a)
    else
        gg.toast("検索結果が見つかりませんでした")
    end
end

function trap()
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("5.0", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
    local revert = gg.getResults(500)
    if #revert > 0 then
        gg.editAll("0",gg.TYPE_FLOAT)
        gg.processResume()
        gg.toast("トラップ無効 ON")
    else
        gg.toast("検索結果が見つかりませんでした")
    end
    
    gg.clearResults()
end


function modifyValues()
    local valuesToModify = {
        "1254340962", "1515282994", "1779273765", 
        "1031339950", "1853065317", "1165510785", 
        "1735305744", "2029965220", "1713446559", 
        "1615132120", "1789885589"
    }

    for _, searchValue in ipairs(valuesToModify) do
        gg.clearResults()
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber(searchValue, gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
        
        local results = gg.getResults(1000)
        local modifiedResults = {}
        local index = 1
        
        for i = 1, #results do
            modifiedResults[index] = {
                address = results[i].address - 0x44,
                flags = gg.TYPE_DWORD,
                value = 0
            }
            index = index + 4
        end
        
        gg.setValues(modifiedResults)
    end
end


function aa5()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.clearResults()
    
    gg.searchNumber("6339221200358174732", gg.TYPE_QWORD, false, gg.SIGN_EQUAL, 0, -1)
    local results = gg.getResults(100)
    
    if #results > 0 then
        local punchDistanceAddress = results[#results].address + 0x70
        gg.clearResults()
        
        gg.searchNumber("7566421188222735354", gg.TYPE_QWORD, false, gg.SIGN_EQUAL, 0, -1)
        local weaponResults = gg.getResults(100)
        
        if #weaponResults > 0 then
            local punchDistanceValue = gg.getValues({{ address = punchDistanceAddress, flags = gg.TYPE_DWORD }})[1].value
            
            local updateTable = {}
            for _, weapon in ipairs(weaponResults) do
                table.insert(updateTable, { address = weapon.address + 0x70, flags = gg.TYPE_DWORD, value = punchDistanceValue })
            end
            gg.setValues(updateTable)
            
        else
            gg.alert("他の武器が見つかりませんでした。")
        end
    else
        gg.alert("パンチのIDが見つかりませんでした。")
    end
end

--5867736346376698970

function aa6()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.clearResults()

    gg.searchNumber("6558252613970925570", gg.TYPE_QWORD)
    local results = gg.getResults(1)

    if #results > 0 then
        local punchDistance = results[1].address + 0x70
        local punchValue = gg.getValues({{ address = punchDistance, flags = gg.TYPE_QWORD }})[1].value
        
        gg.clearResults()
        gg.searchNumber("9021198316195654500", gg.TYPE_QWORD)
        local weaponResults = gg.getResults(100)

        if #weaponResults > 0 then
            for _, weapon in ipairs(weaponResults) do
                weapon.address = weapon.address + 0x70
                weapon.flags = gg.TYPE_QWORD
                weapon.value = punchValue
            end
            gg.setValues(weaponResults)
        else
            gg.alert("他の武器が見つかりませんでした。")
        end
    else
        gg.alert("パンチのIDが見つかりませんでした。")
    end
end

--7594854902521026534 TP

function aa9()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.clearResults()

    gg.searchNumber("7566421188222735354", gg.TYPE_QWORD)
    local results = gg.getResults(1)

    if #results > 0 then
        local punchDistance = results[1].address + 0x70
        local punchValue = gg.getValues({{ address = punchDistance, flags = gg.TYPE_QWORD }})[1].value
        
        gg.clearResults()
        gg.searchNumber("7594854902521026534", gg.TYPE_QWORD)
        local weaponResults = gg.getResults(100)

        if #weaponResults > 0 then
            for _, weapon in ipairs(weaponResults) do
                weapon.address = weapon.address + 0x70
                weapon.flags = gg.TYPE_QWORD
                weapon.value = punchValue
            end
            gg.setValues(weaponResults)
        else
            gg.alert("他の武器が見つかりませんでした。")
        end
    else
        gg.alert("パンチのIDが見つかりませんでした。")
    end
end

function aa10()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.clearResults()

    gg.searchNumber("6558252613970925570", gg.TYPE_QWORD)
    local results = gg.getResults(1)

    if #results > 0 then
        local punchDistance = results[1].address + 0x70
        local punchValue = gg.getValues({{ address = punchDistance, flags = gg.TYPE_QWORD }})[1].value
        
        gg.clearResults()
        gg.searchNumber("5867736346376698970", gg.TYPE_QWORD)
        local weaponResults = gg.getResults(100)

        if #weaponResults > 0 then
            for _, weapon in ipairs(weaponResults) do
                weapon.address = weapon.address + 0x70
                weapon.flags = gg.TYPE_QWORD
                weapon.value = punchValue
            end
            gg.setValues(weaponResults)
        else
            gg.alert("他の武器が見つかりませんでした。")
        end
    else
        gg.alert("パンチのIDが見つかりませんでした。")
    end
end
function aa7()
    gg.alert("これはデバッガー用です。開発者以外は使用できません")
end


function aa8()
    if _G.punchDistanceSet then
        gg.alert("設定はすでに適用されています。")
        return
    end
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.clearResults()
    
    gg.searchNumber("6286271834203446593", gg.TYPE_QWORD, false, gg.SIGN_EQUAL, 0, -1)
    local results = gg.getResults(100)
    
    if #results > 0 then
        local punchDistanceAddress = results[#results].address + 0x70
        gg.clearResults()
        
        gg.searchNumber("7566421188222735354", gg.TYPE_QWORD, false, gg.SIGN_EQUAL, 0, -1)
        local weaponResults = gg.getResults(100)
        
        if #weaponResults > 0 then
            local punchDistanceValue = gg.getValues({{ address = punchDistanceAddress, flags = gg.TYPE_QWORD }})[1].value
            
            local updateTable = {}
            for _, weapon in ipairs(weaponResults) do
                table.insert(updateTable, { address = weapon.address + 0x70, flags = gg.TYPE_QWORD, value = punchDistanceValue })
            end
            gg.setValues(updateTable)
            
            _G.punchDistanceSet = true
            gg.alert("設定が適用されました。")
        else
            gg.toast("他の武器が見つかりませんでした。")
        end
    else
        gg.alert("パンチのIDが見つかりませんでした。")
    end
end

--7358743112637710803

function aa11()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.clearResults()
    gg.searchNumber("8517266019372461953", gg.TYPE_QWORD)
    local results = gg.getResults(1)

    if #results > 0 then
        local punchDistance = results[1].address + 0x70
        local punchValue = gg.getValues({{ address = punchDistance, flags = gg.TYPE_QWORD }})[1].value
        
        gg.clearResults()
        gg.searchNumber("8195448612344042769", gg.TYPE_QWORD)
        local weaponResults = gg.getResults(100)

        if #weaponResults > 0 then
            for _, weapon in ipairs(weaponResults) do
                weapon.address = weapon.address + 0x70
                weapon.flags = gg.TYPE_QWORD
                weapon.value = punchValue
            end
            gg.setValues(weaponResults)
        else
            gg.alert("他の武器が見つかりませんでした。")
        end
    else
        gg.alert("パンチのIDが見つかりませんでした。")
    end
end

function aa12()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.clearResults()
    gg.searchNumber("4788831073787533424", gg.TYPE_QWORD)
    local results = gg.getResults(1)

    if #results > 0 then
        local punchDistance = results[1].address + 0x70
        local punchValue = gg.getValues({{ address = punchDistance, flags = gg.TYPE_QWORD }})[1].value
        
        gg.clearResults()
        gg.searchNumber("7358743112637710803", gg.TYPE_QWORD)
        local weaponResults = gg.getResults(100)

        if #weaponResults > 0 then
            for _, weapon in ipairs(weaponResults) do
                weapon.address = weapon.address + 0x70
                weapon.flags = gg.TYPE_QWORD
                weapon.value = punchValue
            end
            gg.setValues(weaponResults)
        else
            gg.alert("他の武器が見つかりませんでした。")
        end
    else
        gg.alert("パンチのIDが見つかりませんでした。")
    end
end
--7748511682603263836
function aa13()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.clearResults()
    gg.searchNumber("8559582678587391772", gg.TYPE_QWORD)
    local results = gg.getResults(1)

    if #results > 0 then
        local punchDistance = results[1].address + 0x70
        local punchValue = gg.getValues({{ address = punchDistance, flags = gg.TYPE_QWORD }})[1].value
        gg.clearResults()
        gg.searchNumber("7748511682603263836", gg.TYPE_QWORD)
        local weaponResults = gg.getResults(100)

        if #weaponResults > 0 then
            for _, weapon in ipairs(weaponResults) do
                weapon.address = weapon.address + 0x70
                weapon.flags = gg.TYPE_QWORD
                weapon.value = punchValue
            end
            gg.setValues(weaponResults)
        else
            gg.alert("他の武器が見つかりませんでした。")
        end
    else
        gg.alert("パンチのIDが見つかりませんでした。")
    end
end
--4368176234348077357
function aa13()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.clearResults()
    gg.searchNumber("8559582678587391772", gg.TYPE_QWORD)
    local results = gg.getResults(1)

    if #results > 0 then
        local punchDistance = results[1].address + 0x70
        local punchValue = gg.getValues({{ address = punchDistance, flags = gg.TYPE_QWORD }})[1].value
        
        gg.clearResults()
        gg.searchNumber("4368176234348077357", gg.TYPE_QWORD)
        local weaponResults = gg.getResults(100)

        if #weaponResults > 0 then
            for _, weapon in ipairs(weaponResults) do
                weapon.address = weapon.address + 0x70
                weapon.flags = gg.TYPE_QWORD
                weapon.value = punchValue
            end
            gg.setValues(weaponResults)
        else
            gg.alert("他の武器が見つかりませんでした。")
        end
    else
        gg.alert("a")
    end
end
function aa14()
    gg.alert("これはデバッガー用です。開発者以外は使用できません")
end
function rangesdamage()
    gg.alert("これはデバッガー用です。開発者以外は使用できません")
end
function gameZen()
    siubo = gg.multiChoice({
        "カスタム 全体加速",
        "カスタム パンチ範囲拡大",
    }, nil, 'PlayinEscapePro')
    
    if siubo == nil then return end  
    if siubo[1] then gamespeedsetvalue() end
    if siubo[2] then Punchrange() end
    YUNI = -1
end

function gamespeedsetvalue()
    gg.alert("これはデバッガー用です。開発者以外は使用できません")
end
function Punchrange()
    gg.alert("これはデバッガー用です。開発者以外は使用できません")
end


function yokorowa()      
    siubo = gg.multiChoice({
        "よころわY座標固定 ON",
        "よころわY座標固定 OFF",
        "よころわX座標固定 ON",
        "よころわX座標固定 OFF",
    }, nil, 'made by MumbleDebug')
    
    if siubo == nil then return end  
    
    if siubo[1] then YkoteiOn() end
    if siubo[2] then YkoteiOff() end
    if siubo[3] then XkoteiOn() end
    if siubo[4] then XkoteiOff() end
    YUNI = -1
end

local freeze_list_x = {}
local freeze_list_y = {}

function YkoteiOn()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.alert("これはデバッガー用です。開発者以外は使用できません")
end

function YkoteiOff()
    gg.alert("これはデバッガー用です。開発者以外は使用できません")
end





function XkoteiOn()
    gg.alert("これはデバッガー用です。開発者以外は使用できません")
end

function XkoteiOff()
    gg.alert("これはデバッガー用です。開発者以外は使用できません")
end



function by()
    os.exit()
end

Y_R = -1
while true do
    if gg.isVisible(true) then
        Y_R = 1
        gg.setVisible(false)
    end
    if Y_R == 1 then
        if prompt_password() then
            Main()
        end
        Y_R = -1
    end
end
