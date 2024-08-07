local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MorphsFolder = ReplicatedStorage:FindFirstChild("Morphs")

if MorphsFolder then
    local morphs = {}
    
    -- Function to gather morph data
    local function gatherMorphData(morph)
        local displayName = morph:GetAttribute("DisplayName")
        local morphId = morph:GetAttribute("MorphId")
        local restricted = morph:GetAttribute("Restricted")
        
        if displayName and morphId and restricted ~= nil then
            table.insert(morphs, {
                Id = morphId,
                Name = displayName,
                Restricted = restricted
            })
        end
    end
    
    -- Iterate through all children in Morphs folder
    for _, morph in ipairs(MorphsFolder:GetChildren()) do
        gatherMorphData(morph)
    end
    
    -- Sort morphs by ID in descending order
    table.sort(morphs, function(a, b)
        return a.Id > b.Id
    end)
    
    -- Print and save the morph data
    local output = ""
    for _, morph in ipairs(morphs) do
        local restrictedText = morph.Restricted and "yes" or "no"
        local line = string.format("ID %d - %s (Restricted: %s)\n", morph.Id, morph.Name, restrictedText)
        output = output .. line
        print(line)
    end
    
    -- Save to a text file
    local filePath = "MorphsData.txt"
    writefile(filePath, output)
    print("Morphs data saved to " .. filePath)
else
    print("Morphs folder not found in ReplicatedStorage.")
end
