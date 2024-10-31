/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/ServletListener.java to edit this template
 */
package Controller;

import jakarta.servlet.http.HttpSessionAttributeListener;
import jakarta.servlet.http.HttpSessionBindingEvent;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;

/**
 * Web application lifecycle listener.
 *
 * @author
 */
public class NewServletListener implements HttpSessionListener, HttpSessionAttributeListener {

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        System.out.println("Session created: " + se.getSession().getId());
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        System.out.println("Session destroyed: " + se.getSession().getId());
    }

    @Override
    public void attributeAdded(HttpSessionBindingEvent event) {
        System.out.println("Attribute added: " + event.getName() + " = " + event.getValue());
    }

    @Override
    public void attributeRemoved(HttpSessionBindingEvent event) {
        System.out.println("Attribute removed: " + event.getName());
    }

    @Override
    public void attributeReplaced(HttpSessionBindingEvent event) {
        System.out.println("Attribute replaced: " + event.getName() + " with new value: " + event.getValue());
    }
}
