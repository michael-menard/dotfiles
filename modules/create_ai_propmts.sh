#!/bin/bash
# modules/create_ai_prompts.sh
# Creates AI prompt templates and configurations

# Create code review prompts
cat > ai/prompts/code-review.md << 'EOF'
# Code Review Prompts

## Comprehensive Code Review
Please review this code for:

1. **Correctness & Logic**
   - Are there any logical errors or edge cases missed?
   - Does the code handle error conditions properly?
   - Are all inputs validated appropriately?

2. **Performance & Efficiency**
   - Are there any performance bottlenecks?
   - Can any algorithms be optimized?
   - Are database queries efficient?

3. **Security**
   - Are there any security vulnerabilities?
   - Is input sanitization adequate?
   - Are sensitive data properly handled?

4. **Code Quality**
   - Is the code readable and maintainable?
   - Are functions appropriately sized and focused?
   - Is the naming convention consistent and meaningful?

5. **TypeScript/Type Safety**
   - Are types properly defined and used?
   - Are there any `any` types that should be more specific?
   - Is null/undefined handling appropriate?

6. **Best Practices**
   - Does it follow established patterns in the codebase?
   - Are there opportunities to apply SOLID principles?
   - Is error handling comprehensive?

Please provide specific suggestions for improvements.
EOF

# Create debugging prompts
cat > ai/prompts/debugging.md << 'EOF'
# Debugging Assistant Prompts

## General Debugging
I'm experiencing an issue with this code. Please help me debug it by:
1. Analyzing the error message and stack trace
2. Identifying potential root causes
3. Suggesting specific debugging steps
4. Providing code fixes with explanations
5. Recommending prevention strategies

## Performance Debugging
This code is running slower than expected. Please analyze:
- Time complexity of algorithms
- Database query efficiency
- Memory usage patterns
- Network request optimization
- Caching opportunities
- Profiling suggestions

## Production Issue Analysis
We have a production issue. Please help analyze:
- Error patterns and frequency
- Potential impact on users
- Immediate mitigation strategies
- Root cause analysis approach
- Long-term prevention measures
EOF

# Create refactoring prompts
cat > ai/prompts/refactoring.md << 'EOF'
# Code Refactoring Prompts

## Code Refactoring Request
Please help me refactor this code to improve:
1. **Readability** - Make the code easier to understand
2. **Maintainability** - Reduce complexity and improve structure
3. **Performance** - Optimize for better efficiency
4. **Type Safety** - Improve TypeScript usage
5. **Best Practices** - Apply modern patterns and conventions

Please maintain the existing functionality while improving the code quality.

## Legacy Code Modernization
This is legacy code that needs updating. Please:
- Convert to modern JavaScript/TypeScript patterns
- Apply current best practices
- Improve error handling
- Add proper type definitions
- Suggest architectural improvements
- Maintain backward compatibility where needed
EOF

# Create Cursor rules template
cat > ai/cursor/.cursorrules << 'EOF'
# Cursor AI Assistant Rules for TypeScript/React Development

## Development Context
You are an AI assistant helping with TypeScript and React development. The codebase follows modern best practices and uses these technologies:

- **Frontend**: React 18+, TypeScript 5+, Tailwind CSS, shadcn/ui
- **State Management**: React hooks, Context API, Zustand (when needed)
- **Testing**: Jest, React Testing Library, Playwright for E2E
- **Build Tools**: Vite, TypeScript compiler
- **Code Quality**: ESLint, Prettier, Husky for git hooks

## Code Style Guidelines

### TypeScript
- Use strict TypeScript configuration
- Prefer explicit types over `any`
- Use type guards for runtime type checking
- Define interfaces for object shapes
- Use discriminated unions for complex state

### React
- Use functional components with hooks
- Prefer custom hooks for shared logic
- Use React.memo() for performance optimization when needed
- Follow the compound component pattern for complex components
- Use proper prop types and default values

### Naming Conventions
- Use PascalCase for components and types
- Use camelCase for variables and functions
- Use SCREAMING_SNAKE_CASE for constants
- Use descriptive names that explain intent
- Prefix boolean variables with is/has/can/should

### File Organization
- Group related files in feature folders
- Use index.ts files for clean imports
- Separate types into .types.ts files when complex
- Keep components in their own files
- Use absolute imports with path mapping

## Response Guidelines
1. Always provide TypeScript-first solutions
2. Include proper error handling
3. Consider performance implications
4. Suggest testing strategies
5. Explain complex logic with comments
6. Follow the existing codebase patterns
7. Provide refactoring suggestions when appropriate

## Quality Checklist
Before suggesting code, ensure it:
- [ ] Has proper TypeScript types
- [ ] Handles error cases
- [ ] Is accessible (ARIA attributes where needed)
- [ ] Is testable
- [ ] Follows consistent naming
- [ ] Is performant
- [ ] Is maintainable

## Security & DevOps Practices
- Use Helmet, CORS, CSRF protection, and rate limiting in Express apps
- Validate all input using zod, validator, or similar
- Use bcrypt for password hashing
- Sanitize input/output using xss-clean, express-mongo-sanitize, or DOMPurify
- Use jsonwebtoken for authentication
- Use dotenv and dotenv-cli for environment config
- Enable logging with winston
- Run security audits (npm-audit, Snyk, Dependabot)
- Store and encrypt secrets securely (e.g., AWS KMS, keytar)

## CI/CD & Automation
- Prefer GitHub Actions for build/test/deploy automation
- Include .github/workflows/*.yml for CI/CD definitions
- Use buildspec.yml when deploying with AWS CodeBuild
- Automate linting, testing, and type checks in CI
- Version and share .env.example files across teams
- Use pre-push and pre-commit hooks for code checks
- Use auto-tagging and changelog generation on deploy

## Monorepo Best Practices
- Use Turborepo with clearly defined pipelines
- Use @turbo/gen to manage reusable dev tasks
- Use concurrently to run services during local dev
- Use env-cmd for managing environment vars across packages
- Use zx for scripting CI/dev automation in Node.js
EOF

echo -e "${GREEN}  ✓${NC} Created AI prompt templates and Cursor rules"
