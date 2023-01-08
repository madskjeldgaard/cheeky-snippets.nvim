local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local parse = ls.parser.parse_snippet
local common = require "cheeky.common"
local rep = require("luasnip.extras").rep

return {
	s("set", fmt("set({} {})", { i(1, "myvariable"), i(2, "12345") })),
	-- More info: https://asitdhal.medium.com/cmake-functions-and-macros-22293041519f
	s("function", fmt([[function()
{}
endfunction()]], {
    i(1, [[message("I am foo!!")]]),
})),
	s("cpm", fmt([[set(CPM_DOWNLOAD_VERSION 0.27.2)
set(CPM_DOWNLOAD_LOCATION "${CMAKE_BINARY_DIR}/cmake/CPM_${CPM_DOWNLOAD_VERSION}.cmake")

if(NOT (EXISTS ${CPM_DOWNLOAD_LOCATION}))
	message(STATUS "Downloading CPM.cmake")
	file(DOWNLOAD https://github.com/TheLartians/CPM.cmake/releases/download/v${CPM_DOWNLOAD_VERSION}/CPM.cmake ${CPM_DOWNLOAD_LOCATION})
endif()

include(${CPM_DOWNLOAD_LOCATION})

CPMAddPackage(
	NAME []
	GITHUB_REPOSITORY []
	VERSION [])

target_link_libraries([]
[])
		]], {
			i(1, "spdlog"),
			i(2, "gabime/spdlog"),
			i(3, "1.7.3"),
			i(4, "executable_name"),
			rep(1)
		}, {
			delimiters = "[]",
		}))

}
