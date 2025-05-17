If you're using **Yarn**, you can install the latest version of React (currently **React 19.1.0**) with the following command:

```bash
yarn add react@latest react-dom@latest
```

This will:

- Update both `react` and `react-dom` to their latest stable versions.
- Ensure your project is using React 19.1.0 (as of May 2025).

### 🔧 Update TypeScript types

```bash
yarn add -D @types/react @types/react-dom
```

Let me know if you're upgrading from React 18 and need help with migration steps (especially if using Server Components or Actions).

# React Tanstack Query

### **Benefits of React TanStack Query (formerly React Query) Over Traditional Data Fetching Methods**

React TanStack Query is a powerful library for managing **server state** (data fetched from APIs) in React applications. Here’s why it’s superior to traditional approaches like `fetch`/`axios` + `useState`/`useEffect` or Redux:

---

### **1. Automatic Caching & Deduplication**

| **Feature**            | **TanStack Query**                              | **Traditional Methods**                      |
| ---------------------- | ----------------------------------------------- | -------------------------------------------- |
| **Caching**            | ✅ Automatically caches API responses.          | ❌ Manual caching (e.g., Redux, Context).    |
| **Deduplication**      | ✅ Avoids duplicate requests for the same data. | ❌ Requires manual checks.                   |
| **Background Updates** | ✅ Refetches stale data in the background.      | ❌ Manual polling or event-driven refetches. |

**Example**:

```jsx
// TanStack Query: Cache + Auto-Refetch
const { data } = useQuery(["todos"], fetchTodos);

// Traditional: Manual caching + useEffect
const [todos, setTodos] = useState([]);
useEffect(() => {
	fetchTodos().then((data) => setTodos(data));
}, []);
```

---

### **2. Optimistic Updates & Mutations**

| **Feature**       | **TanStack Query**                             | **Traditional Methods**         |
| ----------------- | ---------------------------------------------- | ------------------------------- |
| **Optimistic UI** | ✅ Update UI before server confirmation.       | ❌ Manual state rollbacks.      |
| **Mutations**     | ✅ Built-in `useMutation` for POST/PUT/DELETE. | ❌ Boilerplate with `useState`. |

**Example**:

```jsx
// TanStack Query: Optimistic update
const mutation = useMutation(updateTodo, {
	onMutate: (newTodo) => {
		queryClient.setQueryData(["todos"], (old) => [...old, newTodo]);
	},
});

// Traditional: Manual optimistic update
const [todos, setTodos] = useState([]);
const handleUpdate = async (newTodo) => {
	setTodos([...todos, newTodo]); // Optimistic
	await axios.post("/todos", newTodo); // Actual request
};
```

---

### **3. Pagination, Infinite Queries & Lazy Loading**

| **Feature**         | **TanStack Query**                          | **Traditional Methods**  |
| ------------------- | ------------------------------------------- | ------------------------ |
| **Pagination**      | ✅ `usePaginatedQuery` built-in.            | ❌ Manual page tracking. |
| **Infinite Scroll** | ✅ `useInfiniteQuery` for seamless loading. | ❌ Complex custom logic. |

**Example**:

```jsx
// TanStack Query: Infinite scroll
const { data, fetchNextPage } = useInfiniteQuery(["posts"], fetchPosts, {
	getNextPageParam: (lastPage) => lastPage.nextCursor,
});

// Traditional: Manual infinite scroll
const [posts, setPosts] = useState([]);
const [page, setPage] = useState(1);
const loadMore = () => {
	fetchPosts(page).then((newPosts) => {
		setPosts([...posts, ...newPosts]);
		setPage(page + 1);
	});
};
```

---

### **4. Error & Loading States Simplified**

| **Feature**        | **TanStack Query**            | **Traditional Methods**     |
| ------------------ | ----------------------------- | --------------------------- |
| **Loading States** | ✅ `isLoading`, `isFetching`. | ❌ Manual `useState` flags. |
| **Error Handling** | ✅ Built-in `error` object.   | ❌ Try/catch boilerplate.   |

**Example**:

```jsx
// TanStack Query: Built-in states
const { data, isLoading, error } = useQuery(["todos"], fetchTodos);

// Traditional: Manual states
const [data, setData] = useState([]);
const [isLoading, setIsLoading] = useState(false);
const [error, setError] = useState(null);
useEffect(() => {
	setIsLoading(true);
	fetchTodos()
		.then(setData)
		.catch(setError)
		.finally(() => setIsLoading(false));
}, []);
```

---

### **5. DevTools & Debugging**

| **Feature**      | **TanStack Query**                           | **Traditional Methods**   |
| ---------------- | -------------------------------------------- | ------------------------- |
| **DevTools**     | ✅ Visualize queries, mutations, cache.      | ❌ No built-in tools.     |
| **Auto-Retries** | ✅ Configurable retries for failed requests. | ❌ Manual implementation. |

---

### **6. Performance Optimizations**

| **Feature**                 | **TanStack Query**                         | **Traditional Methods**  |
| --------------------------- | ------------------------------------------ | ------------------------ |
| **Stale Data Revalidation** | ✅ Refetches stale data in the background. | ❌ Manual refresh logic. |
| **Garbage Collection**      | ✅ Automatically removes unused cache.     | ❌ Memory leaks risk.    |

---

### **When to Use TanStack Query?**

- **✅ API-heavy apps**: Frequent data fetching (e.g., dashboards, social media).
- **✅ Real-time updates**: WebSockets + optimistic UI.
- **✅ Complex state**: Pagination, infinite scroll, dependent queries.

### **When to Avoid It?**

- **❌ Simple apps**: A few static API calls (`fetch` + `useEffect` suffices).
- **❌ Server-side state not needed**: For purely client-side state (use `useState`/`useReducer`).

---

### **Comparison with Alternatives**

| **Library**        | **Best For**          | **Drawbacks**                    |
| ------------------ | --------------------- | -------------------------------- |
| **TanStack Query** | Server state (APIs).  | Overkill for simple local state. |
| **Redux**          | Global client state.  | Boilerplate for APIs.            |
| **SWR**            | Lightweight fetching. | Fewer features than TanStack.    |
| **Apollo Client**  | GraphQL APIs.         | GraphQL-only.                    |

---

### **Summary**

TanStack Query eliminates **boilerplate**, **improves performance**, and **simplifies complex server-state scenarios** compared to manual methods. It’s the gold standard for data fetching in modern React apps.

**Get Started**:

```bash
npm install @tanstack/react-query
```

## To run docker file

```bash
docker build .
```

```bash
docker run -p 3000:80 sha256:5d87e13224f1e0d6b40a8e1ba600f92e247dd04709dbd1daab472b99d122ea6f
``` 

