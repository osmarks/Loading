--[[
Loading Simulator
Copyright (c) 2017 Ale32bit

MIT LICENSE: https://github.com/Ale32bit/Loading/blob/master/LICENSE
]]--

local old = os.pullEvent
os.pullEvent = os.pullEventRaw

local splash = {
    "Loading files, maybe...",
    "Why is this taking so long?!",
    "Windows is loading files...",
    "sleep(1)",
    "Loading 42PB of data. Please wait.",
    "Closing handles...",
    "Counting stars in the sky...",
    "Not believing my eyes...",
    "u wnt.. sum loading?",
    "Mining etherum...",
    "Sending files to NSA...",
    "Distributing your credit card information...",
    "Suing everyone...",
    "handle:flushDownToilet()",--stolen from KRapFile :P
    "Waiting for Half-Life 3...",
    "Hacking NSA",
    "Sending NSA data to.. NSA? I guess? Sure, why not.",
    "() { :;};",
    "Executing \"sudo rm -rf --no-preserve-root /*\"",
    "Are you done yet? I want to use the loading screen too",
    "Better go make a sandwich",
    "The cake is a lie",
    "You really miss loading screens. Don't you?",
    "Press CTRL+T. I know you are tired aren't you?",
    "Rahph was here",
    "Rahph, stop messing with my programs.",
    "Don't press the big red button",
    "100% gluten-free!",
    "Voiding warranty...",
    "Error 507611404",
    "Overwriting data with cats...",
    "Converting universe to paperclips...",
    "Self-destruct in 3... 2... 1...",
    "Protocol Omega initiated.",
    "Simulating identical copy of universe...\nYou may even be in one now.",
    "Downloading 100MB of JavaScript and ads",
    "Brute-forcing WiFi password...",
    "Contacting field agents...",
    "Reversing existing progress...",
    "Generating witty loading text"
}

local col
if term.isColor() then
    col = {
        bg = colors.white,
        toload = colors.gray,
        loaded = colors.green,
        text = colors.lightGray,
    }
else
    col = {
        bg = colors.white,
        toload = colors.gray,
        loaded = colors.lightGray,
        text = colors.lightGray,
    }
end

local function to_hex_char(color)
    local power = math.log(color) / math.log(2)
    return string.format("%x", power)
end

term.setBackgroundColor(col.bg)
term.clear()
term.setCursorPos(1,1)
local w,h = term.getSize()

local function write_center(txt)
    _, y = term.getCursorPos()
    for line in txt:gmatch("[^\r\n]+") do
        term.setCursorPos(math.ceil(w/2)-math.ceil(#line/2), y)
        term.write(txt)
        y = y + 1
    end
end

local start = os.clock()
local dead = false

local function run_time()
   return os.clock() - start 
end

parallel.waitForAny(function()
    while true do
        for i = 0,3 do
            if math.random(0, 20) == 7 then i = 6 end
            term.setCursorPos(1,7)
            term.setTextColor(col.text)
            term.setBackgroundColor(col.bg)
            term.clearLine()
            write_center("Loading")
            write(string.rep(".",i))
            sleep(0.5)
        end
    end
end, function()
    local toload = to_hex_char(col.toload)
    local loaded = to_hex_char(col.loaded)
    local text = to_hex_char(col.text)
    local y = h / 2
    local start_x = 3
    local bar_width = w - 4
        
    while true do
        local progress = (math.sin(run_time()) / 2) + 0.5
            
        local loaded_pixels = math.floor(progress * bar_width)
        local remaining_pixels = bar_width - loaded_pixels
            
        term.setCursorPos(start_x, y)
        term.blit((" "):rep(bar_width), text:rep(bar_width), loaded:rep(loaded_pixels) .. toload:rep(remaining_pixels))
            
        sleep(0.5)
    end
end, function()
    while true do
        local choice = splash[math.random(1,#splash)]
        term.setCursorPos(1,math.ceil(h/2)+2)
        term.setBackgroundColor(col.bg)
        term.setTextColor(col.text)
        term.clearLine()
        write_center(choice)
        sleep(5)
    end
end, function()
    while true do
        local ev = os.pullEventRaw("terminate")
        if ev == "terminate" then
            dead = true
            break
        end
    end
end)

local time = run_time()

os.pullEvent = old
term.setBackgroundColor(colors.black)
term.setCursorPos(1,1)
term.setTextColor(colors.white)
term.clear()
if dead then
    print("You gave up at", time, "seconds of loading!")
else
    print("You survived", time, "seconds of loading!")
end

print ""
print "Created by Ale32bit"
print "Modified by osmarks"
