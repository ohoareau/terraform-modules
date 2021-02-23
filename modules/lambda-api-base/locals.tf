locals {
  files = {
    config_js         = ["config.js", var.config_file, "code/config.js"],
    config_statics_js = ["config-statics.js", var.config_statics_file, "code/config-statics.js"],
    config_routes_js  = ["config-routes.js", var.config_routes_file, "code/config-routes.js"],
    utils_js          = ["utils.js", var.utils_file, "code/utils.js"],
    site_webmanifest  = ["statics/site.webmanifest", var.site_webmanifest_file, "code/statics/site.webmanifest"],
    healthz_json      = ["statics/healthz.json", var.healthz_file, "code/statics/healthz.json"],
    robots_txt        = ["statics/robots.txt", var.robots_file, "code/statics/robots.txt"],
    sitemap_xml       = ["statics/sitemap.xml", var.robots_file, "code/statics/sitemap.xml"],
  }
}
