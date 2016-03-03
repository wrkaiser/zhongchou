package com.xiaoyou.exception;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.action.ExceptionHandler;
import org.apache.struts.config.ExceptionConfig;

public class SysExceptionHandler extends ExceptionHandler {
	private static Logger logger = Logger.getLogger(SysExceptionHandler.class);

	public ActionForward execute(Exception ex, ExceptionConfig ec,
			ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws ServletException {
		ActionForward forward = null;
		if (ec.getPath() != null) {
			forward = new ActionForward(ec.getPath());
		} else {
			forward = mapping.getInputForward();
		}
		logger.debug("出现异常", ex);
		if (ex instanceof SysException) {
			SysException se = (SysException) ex;
			String key = se.getKey();
			ActionMessage error = null;
			if (key == null) {
				// 无参，输入message
				error = new ActionMessage(key, se.getMessage());
			} else {
				if (se.getValues() != null) {
					// 带参
					error = new ActionMessage(key, se.getValues());
				} else {
					// 不带参
					error = new ActionMessage(key);
				}
			}
			// 置error入 collection under Globals.ERROR_KEY.
			this.storeException(request, key, error, forward, ec.getScope());
			return forward;
		}
		// 默认 Handle the Exception.
		// Return the ActionForward instance (if any) returned by the called
		// ExceptionHandler
		return super.execute(ex, ec, mapping, form, request, response);
	}

}
