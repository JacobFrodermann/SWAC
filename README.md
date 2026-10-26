# SWAC - SmartWebApplictionComponents

SWAC is designed to make development of webapplications easier. It gives you components that are flexible enought to work with almost every datasets given by json.

Development of SWAC begun in 2020 at the HSBI and is maintained by the SolarComputingLab where its original purpose was to create a toolset to make development of new sciencetific data webpages easy and quick. Some documented components are not available in the opensource version, you can find in the SWAC repository. For more informations and access to non open source components contact: florian.fehring@hsbi.de

Documentation can be found as a webpage, self useing the SWAC and shows the components at work. See the SWACdoc repository for details.

Any help improving this Software is welcome. See CONTRIBUTING.md for more information.

This software is developed for everyone. Please use it wise for freedom, peace and equality. For all beeings.

## Deployment

SWAC is a plain HTML/CSS/JavaScript library. Pages embed it with:

```html
<script src="/SWAC/swac/swac.js" type="module"></script>
```

It is therefore usually deployed as a static web application below the context
root `/SWAC`, next to the application that uses it (for example
`SmartDataJobs`). Many components reference `/SWAC/swac/components/...` paths
absolutely, so the context root must not change.

For the Docker/Payara stack, `Dockerfile` packages the document root into
`/SWAC.war`, and the master Payara image of the `SmartDataDeployment`
repository copies that WAR into `/opt/payara/deployments`:

```bash
docker build -t swac-war:local .
```

`docker/WEB-INF/web.xml` adds a welcome file and the MIME mappings that Payara
lacks (notably `woff2`); `docker/WEB-INF/glassfish-web.xml` pins the context
root to `/SWAC`.

SWAC itself does not ship a `configuration.js`; the embedding application must
provide one at its own root (for example
`SmartDataJobs/web/configuration.js`) to define `SWAC_config`.

## User component URL options

`swac/components/User/User.js` prefixes `SWAC_config.app_root` (the context
root without trailing slash) to every URL option it builds: `afterLoginLoc`,
`afterLogoutLoc`, `loggedinRedirects` values, `accountURL` and
`registrationLink`.

Pass application-absolute values starting with `/`:

```js
var user_options = {
    loginURL: '/SmartUser/smartuser/user/performLogin',
    afterLoginLoc: '/sites/admin/account.html',
    afterLogoutLoc: '/sites/admin/login.html'
};
```

A relative value such as `sites/admin/account.html` is concatenated without a
separator and yields `/SmartUser../sites/admin/account.html`, which does not
exist.

## Licensing

Most parts of this software are useable under the terms of the LGPL.
However some Components inside the directory /swac/components/ are proprietary modules – Not for redistribution or modification without permission.
See LICENSE.md in the directories.