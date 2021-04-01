import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  openSideBar() {
    document.getElementById("mySidebar").style.display = "block";
  }

  closeSideBar() {
    document.getElementById("mySidebar").style.display = "none";
  }
}
