package com.pysarivka.library.config;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;

@Controller
public class CustomErrorController implements ErrorController {

	private final String errorPath = "templates/error/";

	@GetMapping(value = "/error")
	public String handleError(HttpServletRequest request) {
		Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
		if (status != null) {
			Integer statusCode = Integer.valueOf(status.toString());
			if (statusCode == HttpStatus.NOT_FOUND.value()) {
				return errorPath + "404";
			} else if (statusCode == HttpStatus.FORBIDDEN.value()) {
				return errorPath + "403";
			} else if (statusCode == HttpStatus.INTERNAL_SERVER_ERROR.value()) {
				return errorPath + "500";
			}
		}
		return errorPath + "error";
	}
}
