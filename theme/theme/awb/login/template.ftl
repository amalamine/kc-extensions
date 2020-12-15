<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false displayWide=false showAnotherWayIfPresent=true>
  <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
  <html xmlns="http://www.w3.org/1999/xhtml" class="${properties.kcHtmlClass!}">

  <head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="robots" content="noindex, nofollow">

      <#if properties.meta?has_content>
          <#list properties.meta?split(' ') as meta>
            <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
          </#list>
      </#if>
    <title>Attijariwafa bank</title>
    <link rel="icon" href="${url.resourcesPath}/img/favicon.ico" />
      <#if properties.styles?has_content>
          <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
          </#list>
      </#if>
      <#if properties.scripts?has_content>
          <#list properties.scripts?split(' ') as script>
            <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
          </#list>
      </#if>
      <#if scripts??>
          <#list scripts as script>
            <script src="${script}" type="text/javascript"></script>
          </#list>
      </#if>
  </head>

  <body class="${properties.kcBodyClass!}">
    <div class="form-wrapper">
     <img class="d-block mx-auto mb-3 mt-3" src="${url.resourcesPath}/img/logo-black.png" width="192px"/>

    <div class="${properties.kcFormCardClass!} <#if displayWide>${properties.kcFormCardAccountClass!}</#if>">
      <header class="${properties.kcFormHeaderClass!}">
          <#if !(auth?has_content && auth.showUsername() && !auth.showResetCredentials())>
          <h1>${msg("loginTitleHtmlDesc")?no_esc}
              <#if client??>
                  <#if client.name??>
                      <#list client.name?split(r'\s*;\s*', 'r') as idString>
                          <#if idString?contains(locale.current?contains('Fr') ? string("TITLE_FR", "TITLE_EN"))>
                            <span>${idString?remove_beginning(locale.current?contains('Fr') ? string("TITLE_FR#", "TITLE_EN#"))}</span>
                          </#if>
                      </#list>
                  </#if>
              </#if>
          </h1>
          <#else>
              <#if displayRequiredFields>
                <div class="${properties.kcContentWrapperClass!}">
                  <div class="${properties.kcLabelWrapperClass!} subtitle">
                    <span class="subtitle"><span class="required">*</span> ${msg("requiredFields")}</span>
                  </div>
                  <div class="col-md-10">
                      <#nested "show-username">
                    <div class="${properties.kcFormGroupClass!}">
                      <div id="kc-username">
                        <label id="kc-attempted-username">${auth.attemptedUsername}</label>
                        <a id="reset-login" href="${url.loginRestartFlowUrl}">
                          <div class="kc-login-tooltip">
                            <i class="${properties.kcResetFlowIcon!}"></i>
                            <span class="kc-tooltip-text">${msg("restartLoginTooltip")}</span>
                          </div>
                        </a>
                      </div>
                    </div>
                  </div>
                </div>
              <#else>
                  <#nested "show-username">
                <div class="${properties.kcFormGroupClass!}">
                  <div id="kc-username">
                    <label id="kc-attempted-username">${auth.attemptedUsername}</label>
                    <a id="reset-login" href="${url.loginRestartFlowUrl}">
                      <div class="kc-login-tooltip">
                        <i class="${properties.kcResetFlowIcon!}"></i>
                        <span class="kc-tooltip-text">${msg("restartLoginTooltip")}</span>
                      </div>
                    </a>
                  </div>
                </div>
              </#if>
          </#if>
      </header>
      <div id="kc-content">
        <div id="kc-content-wrapper">

            <#-- App-initiated actions should not see warning messages about the need to complete the action -->
            <#-- during login.                                                                               -->
            <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
              <div class="alert alert-${message.type}">
                  <#if message.type = 'success'><span class="${properties.kcFeedbackSuccessIcon!}"></span></#if>
                  <#if message.type = 'warning'><span class="${properties.kcFeedbackWarningIcon!}"></span></#if>
                  <#if message.type = 'error'><span class="${properties.kcFeedbackErrorIcon!}"></span></#if>
                  <#if message.type = 'info'><span class="${properties.kcFeedbackInfoIcon!}"></span></#if>
                <span class="kc-feedback-text">${kcSanitize(message.summary)?no_esc}</span>
              </div>
            </#if>

            <#nested "form">

            <#if auth?has_content && auth.showTryAnotherWayLink() && showAnotherWayIfPresent>
              <form id="kc-select-try-another-way-form" action="${url.loginAction}" method="post" <#if displayWide>class="${properties.kcContentWrapperClass!}"</#if>>
                <div <#if displayWide>class="${properties.kcFormSocialAccountContentClass!} ${properties.kcFormSocialAccountClass!}"</#if>>
                  <div class="${properties.kcFormGroupClass!}">
                    <input type="hidden" name="tryAnotherWay" value="on" />
                    <a href="#" id="try-another-way" onclick="document.forms['kc-select-try-another-way-form'].submit();return false;">${msg("doTryAnotherWay")}</a>
                  </div>
                </div>
              </form>
            </#if>

            <#if displayInfo>
              <div id="kc-info" class="${properties.kcSignUpClass!}">
                <div id="kc-info-wrapper" class="${properties.kcInfoAreaWrapperClass!}">
                    <#nested "info">
                </div>
              </div>
            </#if>
        </div>
      </div>
    </div>
      <div class="auth-desc">
          ${msg("messageTitleDesc")}
      </div>
  </div>
    <footer>
        <#if realm.internationalizationEnabled  && locale.supported?size gt 1>
          <ul id="kc-locale">
            <li class="nav-item dropdown" id="kc-locale-dropdown">
              <a href="#" id="kc-current-locale-link"
                 class="nav-item nav-link dropdown-toggle" data-toggle="dropdown"
                 aria-haspopup="true" aria-expanded="false" onclick="drop()">${locale.current}</a>
              <div class="dropdown-menu dropdown-menu-right" id="kcdrop">
                  <#list locale.supported as l>
                    <a class="dropdown-item" href="${l.url}">${l.label}</a>
                  </#list>
              </div>
            </li>
          </ul>
        </#if>
    </footer>
  </body>
  </html>
</#macro>
