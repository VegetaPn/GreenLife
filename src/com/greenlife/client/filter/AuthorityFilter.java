package com.greenlife.client.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


@WebFilter(filterName="authority",
	urlPatterns=("/Client/*")
)
public class AuthorityFilter implements Filter {

   
    public AuthorityFilter() {
        
    }

	
	public void destroy() {
		
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		request.setCharacterEncoding("UTF-8");
		HttpServletRequest requ = (HttpServletRequest)request;
		
		HttpSession session = requ.getSession();
		
		String requestPath = requ.getServletPath();
	
		
		
		if(session.getAttribute("wechatId") == null 
				&& !requestPath.endsWith("/login.jsp")
				&& !requestPath.endsWith("/login")
				){
			String requestUrl = requestPath;
			if(requ.getQueryString() != null){
				requestUrl = requestUrl + "?" + requ.getQueryString();
		 	}
			
			request.setAttribute("requestUrl", requestUrl);
			request.getRequestDispatcher("/Client/page/login.jsp").forward(request, response);
		}else{
			chain.doFilter(request, response);
		}
		
	}


	public void init(FilterConfig fConfig) throws ServletException {
		
	}

}
