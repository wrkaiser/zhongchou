package com.xiaoyou.filter;

import java.io.IOException;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;


public class SetCharacterEncodingFilter implements Filter {

  protected FilterConfig filterConfig;
  protected String encodingName;
  protected boolean enable;

  public SetCharacterEncodingFilter() {
    this.encodingName = "utf-8";
    this.enable = false;
  }

  public void init(FilterConfig filterConfig) throws ServletException {
    this.filterConfig = filterConfig;
  }

  public void doFilter(ServletRequest request, 
                       ServletResponse response,
                       FilterChain chain) 
                    throws IOException, ServletException {
    request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	chain.doFilter(request, response);
  }
  public void destroy() {
  }
}