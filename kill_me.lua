    local renv = getrenv();
    local identifiedcheat = identifyexecutor();
    local userFingerprint = gethwid();
    local userAgent = table.concat({ identifyexecutor() }, " ");
    local _tablefind = clonefunction(renv.table.find);
    local _tableremove = clonefunction(renv.table.remove);
    local _stringfind = clonefunction(renv.string.find);
    local _error = clonefunction(renv.error)
    
    local cheatIdentifier = {
        Hydrogen = "Hydrogen-Fingerprint",
        Delta = "Delta-Fingerprint",
        Codex = "Hydrogen-Fingerprint"
    }
    
    local selected_identifier = cheatIdentifier[identifiedcheat];
    
    local headers = {
        ["User-Agent"] = "Roblox/WinInet",
        [selected_identifier] = userFingerprint,
    }

    local blockedURLs = {
        "auth.roblox.com",
        "advertise.roblox.com",
        "billing.roblox.com",
        "catalog.roblox.com",
        "apis.roblox.com/contacts-api",
        "develop.roblox.com",
        "economy.roblox.com",
        "groups.roblox.com",
        "inventory.roblox.com",
        "apis.roblox.com/pass-product-purchasing",
        "apis.roblox.com/bundles-product-purchasing",
        "publish.roblox.com",
        "trades.roblox.com",
        "twostepverification.roblox.com"
    }

    getgenv().doRequestInternal = newcclosure(function(_, options)
        if options.Url then
            for _, blockedURL in ipairs(blockedURLs) do
                if _stringfind(options.Url, blockedURL) then
                    _error("Malicious URL interrupted: " .. options.Url)
                end
            end
        end

        return _:RequestInternal(options)  
    end)
    
    getgenv().doHttpGet = newcclosure(function(_, url, ...)
        return _:GetService("HttpService"):GetAsync(url, true, headers)  
    end)

    getgenv().doHttpPost = newcclosure(function(_, url, data, headers)
        local httpService = _:GetService("HttpService")
        local requestBody = httpService:JSONEncode(data)

        return httpService:PostAsync(url, requestBody, Enum.HttpContentType.ApplicationJson, false, headers)
    end)

    local gcBlacklist = {};
    
    getgenv().protectfunction = newcclosure(function(x)
        gcBlacklist[#gcBlacklist + 1] = x;
    end)

    local getGc = getgc;
    getgenv().getgc = newcclosure(function(...)
        local res = getGc(...);
        for i, v in res do
            if _tablefind(gcBlacklist, v) then
                _tableremove(res, i);
            end
        end
        return res;
    end);  
