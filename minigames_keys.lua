local function phone(key)
    print("hiii")
    if key == "space" then print("space") end
    if key == "up" then print("up") end
    if key == "down" then print("down") end
end

local key_functions = {
    phone = phone,
}

return key_functions
