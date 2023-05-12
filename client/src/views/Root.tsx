import Button from '@/components/atoms/Button';

function Root(): JSX.Element {
    return (
        <>
            <h1>React 18 Alpha</h1>
            <Button onClick={() => alert('coś')} />
        </>
    );
}

export default Root;
