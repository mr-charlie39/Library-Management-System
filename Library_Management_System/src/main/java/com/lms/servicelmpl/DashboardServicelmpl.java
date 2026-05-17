package com.lms.servicelmpl;

import com.lms.dao.DashboardDao;
import com.lms.pojo.DashboardStats;

public class DashboardServicelmpl implements com.lms.service.DashboardService {
	
	private DashboardDao dashboardDaom = new com.lms.daolmpl.DashboardDaolmpl();



	@Override
	public DashboardStats fetchDashboardStats() {
		
		DashboardStats stats = dashboardDaom.fetchDashboardStats();
		return stats != null ? stats : new DashboardStats();
		
		
	}

}
