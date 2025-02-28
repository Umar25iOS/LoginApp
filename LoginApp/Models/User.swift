//
//  User.swift
//  LoginApp
//
//  Created by Mohammad Khan on 28/02/25.
//
import RealmSwift

class User: Object {
    @Persisted var email: String = ""
    @Persisted var password: String = ""
}
