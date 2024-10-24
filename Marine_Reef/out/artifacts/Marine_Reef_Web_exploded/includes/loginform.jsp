<%-- 
    Document   : loginform
    Created on : 22 Oct 2024, 21:07:01
    Author     : 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="container" style="margin-bottom: 9%; margin-top: 5%">
        <div class="row justify-content-center">
            <div class="col-md-4">
                <div class="card mt-5">
                    <div class="card-body">
                        <h3 class="text-center mb-4">Login</h3>
                        <form action="LoginServlet" method="post">
                            <div class="form-group">
                                <label for="username">Username</label>
                                <input type="text" class="form-control" id="username" name="username" placeholder="Enter username" required>
                            </div>
                            <div class="form-group">
                                <label for="password">Password</label>
                                <input type="password" class="form-control" id="password" name="password" placeholder="Enter password" required>
                            </div>
                            <div class="d-flex justify-content-center" style="padding-top: 3%">
                                <button type="submit" class="btn btn-primary">Login</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
