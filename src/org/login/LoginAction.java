package org.login;
import java.util.Map;

import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;

import org.apache.struts2.dispatcher.SessionMap;
import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

import dbBean.User;
import util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

public class LoginAction extends ActionSupport implements SessionAware {

	private static final long serialVersionUID = -3434561352924343132L;

	// Generate getters and setters....
	private String userId, userPass, msg;
	private SessionMap<String, Object> sessionMap;
	private User userP;
	
	@Override
	public void setSession(Map<String, Object> map) {
		sessionMap = (SessionMap<String, Object>) map;
	}

	@SuppressWarnings({ "unchecked" })
	public String login() throws Exception {
			  SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
			  Session session2 = sessionFactory.openSession();
			  session2.beginTransaction();
			  
			  TypedQuery<User> query = session2.createQuery("from User where name= :userId AND password= :userPass");
			  query.setParameter("userId",userId);
			  query.setParameter("userPass",userPass);
			  try {
			  userP=(User) query.getSingleResult();
			  }catch (NoResultException nre) {
					this.msg = "Credenziali non Valide";
			  }
			  sessionFactory.close();		
if(userP != null)		{	
		// add the attribute in session		
		sessionMap.put("userId", userP.getName());
		sessionMap.put("id", userP.getIdUser());
		sessionMap.put("role", userP.getRole());
		sessionMap.put("root", "off");
		switch (userP.getRole()) {
        case "customer":  return "login_customer";
        case "admin":  return "login_admin";
        case "dev":  return "login_dev";
        case "super":  {sessionMap.put("root", "on");return "login_super";}
		}
}
System.out.println("Errore sessione inesistente");

	return "LOGIN";
}
	
	public String logout() {
		
		sessionMap.clear();
		sessionMap.invalidate();
		
		return "LOGOUT";
	}

	public SessionMap<String, Object> getSessionMap() {
		return sessionMap;
	}

	public void setSessionMap(SessionMap<String, Object> sessionMap) {
		this.sessionMap = sessionMap;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPass() {
		return userPass;
	}

	public void setUserPass(String userPass) {
		this.userPass = userPass;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

}