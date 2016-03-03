package com.xiaoyou.filter;
import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import com.alsaw.util.JdbcContext;



public class JdbcCleanup implements Filter {

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		String url=((HttpServletRequest) request).getRequestURI();
		try {
			chain.doFilter(request, response);
		} catch (Exception e) {
			throw new ServletException(e);
		} finally {
			JdbcContext.closeCurrentAll();
		}
	}

	public void init(FilterConfig config) throws ServletException {
	}

	public void destroy() {
		JdbcContext.shutdownDataSource();
	}
}