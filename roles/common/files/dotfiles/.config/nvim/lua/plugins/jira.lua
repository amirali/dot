return {
  'letieu/jira.nvim',
  opts = {
    -- Your setup options...
    jira = {
      api_version = '2', -- API version: "2" or "3" (default: "3")
      limit = 200, -- Global limit of tasks per view (default: 200)
      logging = false, -- Enable HTTP request/response logging (default: false)
    },

    active_sprint_query = "project = %s AND sprint in openSprints() ORDER BY Rank ASC",

    -- Saved JQL queries for the JQL tab
    -- Use %s as a placeholder for the project key
    queries = {
      ['Next sprint'] = "project = '%s' AND sprint in futureSprints() ORDER BY Rank ASC",
      ['Backlog'] = "project = '%s' AND (issuetype IN standardIssueTypes() OR issuetype = Sub-task) AND (sprint IS EMPTY OR sprint NOT IN openSprints()) AND statusCategory != Done ORDER BY Rank ASC",
      ['My Tasks'] = 'assignee = currentUser() AND statusCategory != Done ORDER BY updated DESC',
    },

    -- Project-specific overrides
    -- Still think about this config, maybe not good enough
    -- projects = {
    --   ['DEV'] = {
    --     story_point_field = 'customfield_10035', -- Custom field ID for story points
    --     custom_fields = { -- Custom field to display in markdown view
    --       { key = 'customfield_10016', label = 'Acceptance Criteria' },
    --     },
    --   },
    -- },
  },
}
