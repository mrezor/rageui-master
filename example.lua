print("^1 RageUI - testing file is started. ^0")

local mainMenu = RageUI.CreateMenu("YOUR TITLE", "YOU SUB TITLE")
local subMenu =  RageUI.CreateSubMenu(mainMenu, "A TITLE", "A SUB TITLE")

mainMenu:DisplayGlare(false)
mainMenu.Closed = function()
    print('Closed Showcase Menu')
end
mainMenu.EnableMouse = true
mainMenu.onIndexChange = function(Index)
    print(Index)
end

--> This will show the glare on the submenu : 
subMenu:DisplayGlare(true)

--> This will show the page counter on the submenu :
subMenu:DisplayPageCounter(true)

local ParentData = {mom = 0, dad = 0}
local index = {
    checkbox = false,
    list = 2,
    heritage = 0.5,
    slider = 50,
    sliderprogress = 50,
    grid = {
        default = { x = 0.5, y = 0.5 },
        horizontal = { x = 0.5 },
        vertical = { y = 0.5 },
    },
    percentage = 0.5,
    color = {
        primary = { 1, 5 },
        secondary = { 1, 5 }
    },
}

local description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur"

Citizen.CreateThread(function()
    while (true) do
        Citizen.Wait(1.0)

        RageUI.IsVisible(mainMenu, function()

            RageUI.Button('Basic Items', description, {}, true, {
                onHovered = function()
                    Visual.Subtitle("onHovered", 100)
                end,
                onSelected = function()
                    Visual.Subtitle("onSelected", 100)
                end,
            });

            RageUI.Line({255, 0, 0, 255}, 350, 20, 20) -- Color, Size, Space at the top, Space at the bottom

            RageUI.Checkbox('Checkbox', description, index.checkbox, {}, {
                onChecked = function()
                    Visual.Subtitle("onChecked", 100)
                    mainMenu.TitleFont = 7
                end,
                onUnChecked = function()
                    Visual.Subtitle("onUnChecked", 100)
                    mainMenu.TitleFont = 1
                end,
                onSelected = function(Index)
                    index.checkbox = Index
                    --- Logic on selected items
                end
            })

            RageUI.List('List Item', {
                { Name = "Paco", Value = 1 },
                { Name = "Is", Value = 2 },
                { Name = "Awesome", Value = 60 },
                { Name = "Bro", Value = 50 },
            }, index.list, description, {}, true, {
                onListChange = function(Index, Item)
                    index.list = Index;
                    Visual.Subtitle("onListChange", 100)
                end,
                onSelected = function(Index, Item)
                    Visual.Subtitle("onSelected", 100)
                end,
            })

            RageUI.UISliderHeritage('Heritage Item', index.heritage, description, {
                onSliderChange = function(Float, Index)
                    index.heritage = Index;
                    mainMenu.TitleScale = Float
                end,
                onSelected = function(Float, Index)
                    Visual.Subtitle("onSelected", 100)
                end
            })

            RageUI.Separator("Paco is the best.")

            RageUI.Slider('Slider Item', index.slider, 100, description, true, {}, true, {
                onSliderChange = function(Index)
                    index.slider = Index
                    Visual.Subtitle("onSliderChange", 100)
                end,
                onSelected = function(Index)
                    Visual.Subtitle("onSelected", 100)
                end
            })

            RageUI.SliderProgress('SliderProgress Item', index.sliderprogress, 100, description, {
                ProgressBackgroundColor = { R = 255, G = 0, B = 0, A = 200 },
                ProgressColor = { R = 0, G = 255, B = 0, A = 255 },
            }, true, {
                onSliderChange = function(Index)
                    index.sliderprogress = Index
                    Visual.Subtitle("onSliderChange", 100)
                end,
                onSelected = function(Index)
                    Visual.Subtitle("onSelected", 100)
                end
            })

            RageUI.Button('SubMenu', "Description here", {}, true, {onSelected = function() print("HELLO WORLD !") end}, subMenu);

            RageUI.Button('Simple Bouton with background colour', "Description here", { RightLabel = "", Color = { HightLightColor = { 0, 155, 0, 150 }, BackgroundColor = { 38, 85, 150, 160 } }}, true, {onSelected = function() print("HELLO WORLD !") end});

        end, function()

            RageUI.Grid(index.grid.default.x, index.grid.default.y, 'Top Text', 'Bottom Text', 'Left Text', 'Right Text', {
                onSelected = function(IndexX, IndexY, X, Y)

                end,
                onPositionChange = function(IndexX, IndexY, X, Y)
                    Visual.Subtitle(string.format('x = %s, y = %s', X, Y), 1000)
                    index.grid.default.x = IndexX
                    index.grid.default.y = IndexY
                end
            }, 1)

            RageUI.GridHorizontal(index.grid.horizontal.x, 'Left Text', 'Right Text', {
                onSelected = function(IndexX, IndexY, X, Y)

                end,
                onPositionChange = function(IndexX, IndexY, X, Y)
                    index.grid.horizontal.x = IndexX
                end
            }, 2)

            RageUI.GridVertical(index.grid.vertical.y, 'Top Text', 'Bottom Text', {
                onSelected = function(IndexX, IndexY, X, Y)

                end,
                onPositionChange = function(IndexX, IndexY, X, Y)
                    index.grid.vertical.y = IndexY
                end
            }, 3)

            RageUI.PercentagePanel(index.percentage, 'Header Text', 'Min Text', 'Max Text', {
                onSelected = function(Percentage)

                end,
                onProgressChange = function(Percentage)
                    index.percentage = Percentage
                end
            }, 4)

            RageUI.ColourPanel("Couleur de Paco", RageUI.PanelColour.HairCut, index.color.primary[1], index.color.primary[2], {
                onColorChange = function(MinimumIndex, CurrentIndex)
                    index.color.primary[1] = MinimumIndex
                    index.color.primary[2] = CurrentIndex
                end
            }, 6, {
                Seperator = { Text = "/" }
            })

            RageUI.ColourPanel("Couleur de paco secondaire", RageUI.PanelColour.HairCut, index.color.secondary[1], index.color.secondary[2], {
                onColorChange = function(MinimumIndex, CurrentIndex)
                    index.color.secondary[1] = MinimumIndex
                    index.color.secondary[2] = CurrentIndex
                end
            }, 6)
        end)

        --> SubMenu : 
        RageUI.IsVisible(subMenu, function()
            --> EXEMPLE ON HOW TO USE HERITAGE WINDOW : 
            RageUI.Window.Heritage(ParentData['mom'], ParentData['dad'])

            --> your logic here ... 
        end, function() end)
    end
end)


Keys.Register('E', 'E', 'Open RageUI Showcase menu default.', function()
    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))
end)