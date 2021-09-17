#!/bin/bash

#=================================================
# COMMON VARIABLES
#=================================================

# dependencies used by the app
pkg_dependencies="git jq build-essential nodejs g++ gettext-base rsync"

#=================================================
# PERSONAL HELPERS
#=================================================

function install_dependencies {
	ynh_install_app_dependencies $pkg_dependencies
	ynh_install_extra_app_dependencies --repo="deb https://dl.yarnpkg.com/debian/ stable main" --package="yarn" --key="https://dl.yarnpkg.com/debian/pubkey.gpg"
}

function setup_source {
	if [ ! -d "$final_path/.git" ]; then
		git clone https://github.com/cdr/code-server/ "$final_path" --no-checkout 2>&1
	fi
	pushd "$final_path"
		git fetch --all 2>&1
		git reset --hard 2>&1
		git checkout 798dc0baf284416dbbf951e4ef596beeab6cb6c4 2>&1
	popd

	ynh_replace_special_string -m "throw new Error('compilation requires 4GB of RAM')" -r "console.log('compilation requires 4GB of RAM')" -f "$final_path/lib/vscode/build/lib/compilation.js"
	ynh_replace_special_string -m "throw new Error('compilation requires 4GB of RAM')" -r "console.log('compilation requires 4GB of RAM')" -f "$final_path/lib/vscode/build/lib/compilation.ts"

	set_permissions
}

function set_permissions {
	chown -R root:$admin "$final_path"
	chmod -R g=u,g-w,o-rwx "$final_path"

	mkdir -p "$data_path"/{user-data,extensions}
	chown -R $admin:$admin "$data_path"
	chmod -R g=u,g-w,o-rwx "$data_path"

	mkdir -p "/var/log/$app"
	chown -R root:root "/var/log/$app"
	chmod -R g=u,g-w,o-rwx "/var/log/$app"
}

function set_node_vars {
	ynh_exec_warn_less ynh_install_nodejs --nodejs_version=14
	ynh_use_nodejs
	node_path=$nodejs_path:$(sudo -u $admin sh -c 'echo $PATH')
}

function build_app {
	set_node_vars

	pushd "$final_path"
		chown -R $admin:$admin "$final_path"
		sudo -u $admin touch $final_path/.yarnrc
		sudo -u $admin env "PATH=$node_path" yarn --cache-folder "$final_path/yarn-cache" --use-yarnrc "$final_path/.yarnrc" config set python python3 2>&1
		sudo -u $admin env "PATH=$node_path" yarn --cache-folder "$final_path/yarn-cache" --use-yarnrc "$final_path/.yarnrc" install 2>&1
		sudo -u $admin env "PATH=$node_path" yarn --cache-folder "$final_path/yarn-cache" --use-yarnrc "$final_path/.yarnrc" build 2>&1
		sudo -u $admin env "PATH=$node_path" yarn --cache-folder "$final_path/yarn-cache" --use-yarnrc "$final_path/.yarnrc" build:vscode 2>&1
		sudo -u $admin env "PATH=$node_path" yarn --cache-folder "$final_path/yarn-cache" --use-yarnrc "$final_path/.yarnrc" release 2>&1
		cd release
		sudo -u $admin env "PATH=$node_path" yarn --cache-folder "$final_path/yarn-cache" --use-yarnrc "$final_path/.yarnrc" install --production 2>&1
		cd ..
		sudo -u $admin env "PATH=$node_path" yarn --cache-folder "$final_path/yarn-cache" --use-yarnrc "$final_path/.yarnrc" release:standalone 2>&1
	popd

	set_permissions
}

function add_configs {
	if [ ! -z "$hashed_password" ]; then
		auth="password"
	else
		auth="none"
	fi

	if [ ! -z "$enable_proposed_api" ]; then
		enable_proposed_api_string="enable-proposed-api: [ $enable_proposed_api ]"
	else
		enable_proposed_api_string=""
	fi

	ynh_add_config --template="config.yaml" --destination="$final_path/config.yaml"

	ynh_add_config --template="code-server.env" --destination="$final_path/code-server.env"

	set_permissions
}

function load_settings {
	app=$YNH_APP_INSTANCE_NAME

	final_path=$(ynh_app_setting_get --app=$app --key=final_path)
	data_path=$(ynh_app_setting_get --app=$app --key=data_path)
	domain=$(ynh_app_setting_get --app=$app --key=domain)
	path_url=$(ynh_app_setting_get --app=$app --key=path)
	admin=$(ynh_app_setting_get --app=$app --key=admin)
	hashed_password=$(ynh_app_setting_get --app=$app --key=hashed_password)
	extension_service_url=$(ynh_app_setting_get --app=$app --key=extension_service_url)
	extension_item_url=$(ynh_app_setting_get --app=$app --key=extension_item_url)
	enable_proposed_api=$(ynh_app_setting_get --app=$app --key=enable_proposed_api)
	port=$(ynh_app_setting_get --app=$app --key=port)
}

#=================================================
# EXPERIMENTAL HELPERS
#=================================================

#=================================================
# FUTURE OFFICIAL HELPERS
#=================================================
