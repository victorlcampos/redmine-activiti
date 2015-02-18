package com.redmine.listerners;

import org.activiti.engine.delegate.event.ActivitiEntityEvent;
import org.activiti.engine.delegate.event.ActivitiEvent;
import org.activiti.engine.delegate.event.ActivitiEventListener;
import org.activiti.engine.impl.event.logger.handler.TaskCreatedEventHandler;
import org.activiti.engine.impl.persistence.entity.TaskEntity;

public class RedmineListener implements ActivitiEventListener {

	@Override
	public void onEvent(ActivitiEvent event) {
		switch (event.getType()) {
		case TASK_CREATED:
			create_task_redmine(event);
		default:
	        System.out.println("Event received: " + event.getType());
		}		
	}

	@Override
	public boolean isFailOnException() {
		return false;
	}

	private void create_task_redmine(ActivitiEvent event) {
		TaskEntity task = (TaskEntity) ((ActivitiEntityEvent) event).getEntity();
	}
}
