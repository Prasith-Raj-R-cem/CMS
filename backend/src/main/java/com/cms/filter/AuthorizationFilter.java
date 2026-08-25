package com.cms.filter;

import java.io.IOException;

import com.cms.model.Role;
import com.cms.model.User;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter("/admin/*")
public class AuthorizationFilter implements Filter {

    @Override
    public void doFilter(
            ServletRequest request,
            ServletResponse response,
            FilterChain chain
    ) throws IOException, ServletException {

        HttpServletRequest httpRequest =
                (HttpServletRequest) request;

        HttpServletResponse httpResponse =
                (HttpServletResponse) response;

        HttpSession session =
                httpRequest.getSession(false);

        if (session == null) {

            httpResponse.sendRedirect(
                    httpRequest.getContextPath() + "/login"
            );

            return;
        }

        User user =
                (User) session.getAttribute("user");

        if (user == null) {

            httpResponse.sendRedirect(
                    httpRequest.getContextPath() + "/login"
            );

            return;
        }

        if (!Role.ADMIN.equals(user.getRole())) {

            httpResponse.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Access denied"
            );

            return;
        }

        chain.doFilter(request, response);
    }
}