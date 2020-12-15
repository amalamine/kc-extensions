<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=social.displayInfo displayWide=(realm.password && social.providers??); section>
    <#if section = "header">
        ${msg("doLogIn")}
    <#elseif section = "form">
      <div id="kc-form" <#if realm.password && social.providers??>class="${properties.kcContentWrapperClass!}"</#if>>
        <div id="kc-form-wrapper" <#if realm.password && social.providers??>class="${properties.kcFormSocialAccountContentClass!} ${properties.kcFormSocialAccountClass!}"</#if>>
            <#if realm.password>
              <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                <div class="${properties.kcFormGroupClass!}">
                    <#if usernameEditDisabled??>
                      <input tabindex="1" id="username" class="${properties.kcInputClass!}" name="username"
                             value="${(login.username!'')}" type="text" disabled
                             placeholder="${msg("usernameOrEmail")}"/>
                    <#else>
                      <input tabindex="1" id="username" class="${properties.kcInputClass!}" name="username"
                             value="${(login.username!'')}" type="text" autofocus autocomplete="off"
                             placeholder="${msg("username")}"/>
                    </#if>
                </div>

                <div class="${properties.kcFormGroupClass!}">
                  <input tabindex="2" id="password" class="${properties.kcInputClass!}" name="password"
                         type="password" autocomplete="off" placeholder="${msg("password")}"/>
                </div>

                <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
                  <div id="kc-form-options">
                      <#if realm.rememberMe && !usernameEditDisabled??>
                        <div class="checkbox">
                          <label>
                              <#if login.rememberMe??>
                                <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox"
                                       checked> ${msg("rememberMe")}
                              <#else>
                                <input tabindex="3" id="rememberMe" name="rememberMe"
                                       type="checkbox"> ${msg("rememberMe")}
                              </#if>
                          </label>
                        </div>
                      </#if>
                  </div>
                </div>

                <div id="kc-form-buttons" class="${properties.kcFormGroupClass!}">
                  <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                  <input tabindex="4" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>
                </div>

                <div class="${properties.kcFormOptionsWrapperClass!}">
                    <#if realm.resetPasswordAllowed>
                        <#if client.description??>
                          <div class="footer-links">
                              <#list client.description?split(r'\s*;\s*', 'r') as idString>
                                  <#if idString?contains("FMDP")>
                                    <span><a tabindex="5" href="${idString?remove_beginning("FMDP#")}?lang=${locale.current?contains('Fr') ? string('fr', 'en')}"
                                             class="forgot-password ">${msg("doForgotPassword")}</a></span>
                                  </#if>
                              </#list>
                          </div>
                        </#if>

                    </#if>
                </div>
              </form>
            </#if>
        </div>
          <#if realm.password && social.providers??>
            <div id="kc-social-providers" class="${properties.kcFormSocialAccountContentClass!} ${properties.kcFormSocialAccountClass!}">
              <ul class="${properties.kcFormSocialAccountListClass!} <#if social.providers?size gt 4>${properties.kcFormSocialAccountDoubleListClass!}</#if>">
                  <#list social.providers as p>
                    <li class="${properties.kcFormSocialAccountListLinkClass!}"><a href="${p.loginUrl}" id="zocial-${p.alias}" class="zocial ${p.providerId}"> <span>${p.displayName}</span></a></li>
                  </#list>
              </ul>
            </div>
          </#if>
      </div>
    <#elseif section = "info" >
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
          <div id="kc-registration">
            <span>${msg("noAccount")} <a tabindex="6" href="${url.registrationUrl}">${msg("doRegister")}</a></span>
          </div>
        </#if>
    </#if>

</@layout.registrationLayout>
