import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Injectable({
    providedIn: 'root'
})
export class HttpService {

    constructor(private _http: HttpClient) { }

    logIn(user) {
        return this._http.post("/logIn", user)
    }

    getUsers() {
        return this._http.get("/users")
    }

    deleteUser(id) {
        return this._http.delete("/user/" + id)
    }

    createNewUser(user) {
        return this._http.post("/user", user)
    }

    getAdmins() {
        return this._http.get("/users/admin")
    }

    getEmployees() {
        return this._http.get("/users/employee")
    }

    makeCustomerAccess(id) {
        return this._http.put("/access/customer/" + id, {})
    }
    makeEmployeeAccess(id) {
        return this._http.put("/access/employee/" + id, {})
    }

    makeAdminAccess(id) {
        return this._http.put("/access/admin/" + id, {})
    }


    getAllCategories() {
        return this._http.get("/categories")
    }

    addCategory(newCategory) {
        return this._http.post("/category", newCategory)
    }

    getAllItems() {
        return this._http.get("/items")
    }

    addItem(item) {
        return this._http.post('/item', item)
    }
    updateItem(item) {
        return this._http.put('/item', item)
    }

    getItem(id) {
        return this._http.get('/item/' + id)
    }
}
