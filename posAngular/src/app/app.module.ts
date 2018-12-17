import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { FrontPageComponent } from './front-page/front-page.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { HttpService } from './service/http.service';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { MaterialModule } from './materials';
import { DashboardComponent } from './dashboard/dashboard.component';
import { LayoutModule } from '@angular/cdk/layout';
import { MatToolbarModule, MatButtonModule, MatSidenavModule, MatIconModule, MatListModule, MatNativeDateModule } from '@angular/material';
import { HomeComponent } from './dashboard/home/home.component';
import { CurrentOrdersComponent } from './dashboard/current-orders/current-orders.component';
import { SellsComponent } from './dashboard/sells/sells.component';
import { ItemsComponent } from './dashboard/items/items.component';
import { EmployeesComponent } from './dashboard/employees/employees.component';
import { UsersComponent } from './dashboard/users/users.component';

@NgModule({
    declarations: [
        AppComponent,
        FrontPageComponent,
        DashboardComponent,
        HomeComponent,
        CurrentOrdersComponent,
        SellsComponent,
        ItemsComponent,
        EmployeesComponent,
        UsersComponent
    ],
    imports: [
        BrowserModule,
        AppRoutingModule,
        FormsModule,
        BrowserAnimationsModule,
        MaterialModule,
        ReactiveFormsModule,
        HttpClientModule,
        LayoutModule,
        MatToolbarModule,
        MatButtonModule,
        MatSidenavModule,
        MatIconModule,
        MatListModule,
        MatNativeDateModule
    ],
    providers: [HttpService],
    bootstrap: [AppComponent]
})
export class AppModule { }
