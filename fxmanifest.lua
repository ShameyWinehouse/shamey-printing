fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
lua54 'yes'

client_scripts {
	-- "client/cloud_storage/*.lua",
	"client/*.lua",
}
server_scripts {
	"server/*.lua",
	"@oxmysql/lib/MySQL.lua",
}
shared_scripts {
	"@jo_libs/init.lua",
	"config.lua",
	"shared/*.lua",
	"shared/**/*.lua",
}

files {
	"ui/dist/*",
	"ui/dist/**/*",
  }
ui_page "ui/dist/index.html"

dependencies {
	"rainbow-core",
	"vorp_inputs",
}

jo_libs {
	"me",
}


author 'Shamey Winehouse'
description 'License: GPL-3.0-only'