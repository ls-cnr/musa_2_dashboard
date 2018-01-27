package org.login;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.StrutsStatics;

import org.login.LoginAction;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public class LoginInterceptor extends AbstractInterceptor implements StrutsStatics {
	
	private static final long serialVersionUID = 3479461104321915623L;
	
	private static final Log log = LogFactory.getLog(LoginInterceptor.class);
    private static final String USER_HANDLE = "userId";

    public void init() {
            log.info("Intializing LoginInterceptor");
    }

    public void destroy() {
    }

    public String intercept(ActionInvocation invocation) throws Exception {

            final ActionContext context = invocation.getInvocationContext();
            HttpServletRequest request = (HttpServletRequest) context.get(HTTP_REQUEST);
            HttpSession session = request.getSession(true);
String role;
            // Is there a "user" object stored in the user's HttpSession?
            Object user = session.getAttribute(USER_HANDLE);
            if (user == null) {
                    // The user has not logged in yet.

                    /* The user is attempting to log in. */
                    if (invocation.getAction().getClass().equals(LoginAction.class))
                    {
                            return invocation.invoke();
                    }
                    
                    return "login2";
            } else {
            	
                role=session.getAttribute("role").toString();	
    	        switch (role) {
    	        
    	            case "customer":  {
    	            	if(request.getRequestURI().startsWith(request.getContextPath()+"/customer") || (invocation.getAction().getClass().equals(LoginAction.class)))
    	            		return invocation.invoke();
    	            	else return "login2";
    	            	}  
    	            
    	            case "dev":  {
    	            	if(request.getRequestURI().startsWith(request.getContextPath()+"/devTeam") || (invocation.getAction().getClass().equals(LoginAction.class)))
    	            		return invocation.invoke();
    	            	else return "login2";
    	            	}  
    	            
    	            case "admin":  {
    	            	if(request.getRequestURI().startsWith(request.getContextPath()+"/admin") || (invocation.getAction().getClass().equals(LoginAction.class)))
    	            		return invocation.invoke();
    	            	else return "login2";               
    	            	}  
    	        }
    	        
                    return invocation.invoke();
            }
    }
}